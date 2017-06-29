package shared.plugin;

import android.app.Activity;
import android.content.ContentUris;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.os.Environment;
import android.provider.DocumentsContract;
import android.provider.MediaStore;

import com.t5online.nebulacore.bridge.NebulaActivity;
import com.t5online.nebulacore.plugin.Plugin;
import com.t5online.nebulacore.plugin.PluginResult;

import org.json.JSONObject;

/**
 * Created by sungju on 2017. 6. 7..
 */

public class FileSystemPlugin extends Plugin {

    public static final String PLUGIN_GROUP_FILESYSTEM = "filesystem";

    public void selectFile (float quality, float width, float height) {
        try {
            if (bridgeContainer.getSync()) {
                JSONObject ret = new JSONObject();
                ret.put("code", STATUS_CODE_ERROR);
                ret.put("message", "unsupported sync plugin");
                resolve(ret);
                return;
            }
            final NebulaActivity activity = (NebulaActivity) this.bridgeContainer.getActivity();
            activity.addActivityResultHandler(PICK_PHOTO_FOR_AVATAR, new NebulaActivity.ActivityResultHandler() {
                @Override
                public void onActivityResult(int resultCode, Intent data) {
                    try {
                        if (resultCode == Activity.RESULT_OK) {
                            String filePath = uriToFilePath(activity, data.getData());
                            if (filePath != null) {
                                JSONObject ret = new JSONObject();
                                ret.put("code", STATUS_CODE_SUCCESS);
                                ret.put("message", filePath);
                                resolve(ret);
                            } else {
                                JSONObject ret = new JSONObject();
                                ret.put("code", STATUS_CODE_ERROR);
                                ret.put("message", "선택한 파일의 경로를 얻을 수 없습니다");
                                resolve(ret);
                            }
                        } else {
                            JSONObject ret = new JSONObject();
                            ret.put("code", STATUS_CODE_ERROR);
                            ret.put("message", "파일을 선택하지 않았습니다");
                            resolve(ret);
                        }
                        activity.removeActivityResultHandler(PICK_PHOTO_FOR_AVATAR);
                    }catch (Exception e) {
                            e.getStackTrace();
                            reject();
                    }
                }
            });
            pickImage(activity);
        } catch (Exception e) {
            e.getStackTrace();
            reject();
        }
    }


    private static final int PICK_PHOTO_FOR_AVATAR = 1;
    public void pickImage(Activity context) {
        Intent intent = new Intent(Intent.ACTION_GET_CONTENT);
        intent.setType("image/*");
        context.startActivityForResult(intent, PICK_PHOTO_FOR_AVATAR);
    }

    private String uriToFilePath(Context context, Uri uri) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            if (DocumentsContract.isDocumentUri(context, uri)) {
                if (isExternalStorageDocument(uri)) {
                    final String docId = DocumentsContract.getDocumentId(uri);
                    final String[] split = docId.split(":");
                    final String type = split[0];
                    if ("primary".equalsIgnoreCase(type)) {
                        return Environment.getExternalStorageDirectory() + "/" + split[1];
                    }
                }
                else if (isDownloadsDocument(uri)) {
                    final String id = DocumentsContract.getDocumentId(uri);
                    final Uri contentUri = ContentUris.withAppendedId(
                            Uri.parse("content://downloads/public_downloads"), Long.valueOf(id));
                    return getDataColumn(context, contentUri, null, null);
                }
                // MediaProvider
                else if (isMediaDocument(uri)) {
                    final String docId = DocumentsContract.getDocumentId(uri);
                    final String[] split = docId.split(":");
                    final String type = split[0];

                    Uri contentUri = null;
                    if ("image".equals(type)) {
                        contentUri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI;
                    } else if ("video".equals(type)) {
                        contentUri = MediaStore.Video.Media.EXTERNAL_CONTENT_URI;
                    } else if ("audio".equals(type)) {
                        contentUri = MediaStore.Audio.Media.EXTERNAL_CONTENT_URI;
                    }

                    final String selection = "_id=?";
                    final String[] selectionArgs = new String[] {
                            split[1]
                    };

                    return getDataColumn(context, contentUri, selection, selectionArgs);
                }
            }
            else if ("content".equalsIgnoreCase(uri.getScheme())) {
                return getDataColumn(context, uri, null, null);
            }
            else if ("file".equalsIgnoreCase(uri.getScheme())) {
                return uri.getPath();
            }
        }

        return null;

    }

    public static String getDataColumn(Context context, Uri uri, String selection, String[] selectionArgs) {
        Cursor cursor = null;
        final String column = "_data";
        final String[] projection = {column};
        try {
            cursor = context.getContentResolver().query(uri, projection, selection, selectionArgs,
                    null);
            if (cursor != null && cursor.moveToFirst()) {
                final int column_index = cursor.getColumnIndexOrThrow(column);
                return cursor.getString(column_index);
            }
        } finally {
            if (cursor != null)
                cursor.close();
        }
        return null;
    }

    public boolean isExternalStorageDocument(Uri uri) {
        return "com.android.externalstorage.documents".equals(uri.getAuthority());
    }

    public boolean isDownloadsDocument(Uri uri) {
        return "com.android.providers.downloads.documents".equals(uri.getAuthority());
    }

    public boolean isMediaDocument(Uri uri) {
        return "com.android.providers.media.documents".equals(uri.getAuthority());
    }
}

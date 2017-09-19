//
//  FileSystemPlugin.m
//  FileSystemModule
//
//  Created by JoAmS on 2017. 6. 14..
//  Copyright © 2017년 t5online. All rights reserved.
//

#import "FileSystemPlugin.h"
#import <Photos/Photos.h>

#define ERROR_CODE_NOT_EXIST_FILE @"E10001"

#define PHOTO_FOLDER @"Photos"

@class ImagePickerController;
@protocol ImagePickerControllerDelegate <NSObject>
@optional
- (void)imagePickerController:(ImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info;
- (void)imagePickerControllerDidCancel:(ImagePickerController*)picker;
@end

@interface ImagePickerController : UIImagePickerController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong) id<ImagePickerControllerDelegate> aDelegate;
@end

@implementation ImagePickerController
- (id)init {
    self = [super init];
    
    if (self) {
        [super setSourceType:UIImagePickerControllerSourceTypeCamera];
        [super setDelegate:self];
    }
    
    return self;
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if (_aDelegate && [_aDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingMediaWithInfo:)]) {
        [_aDelegate imagePickerController:self didFinishPickingMediaWithInfo:info];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if (_aDelegate && [_aDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [_aDelegate imagePickerControllerDidCancel:self];
    }
}
@end

@class ImagePickerController;
@interface FileSystemPlugin () <ImagePickerControllerDelegate>

@property (nonatomic, assign) float iQuality;
@property (nonatomic, assign) float iWidth;
@property (nonatomic, assign) float iHeight;

@property (nonatomic, strong) ImagePickerController* imagePickerController;
@end

@implementation FileSystemPlugin

- (BOOL)isSupportSync
{
    return NO;
}

- (void)selectFile:(NSNumber*)quality width:(NSNumber*)Width height:(NSNumber*)height
{
    _iQuality = [quality floatValue];
    _iWidth = [Width floatValue];
    _iHeight = [height floatValue];
    
    _imagePickerController = [[ImagePickerController alloc] init];
    [_imagePickerController setADelegate:self];
    [_imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    dispatch_async(dispatch_get_main_queue(),^{
        [self.bridgeContainer.viewController presentViewController:_imagePickerController animated:YES completion:nil];
    });}

#pragma mark - ImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *filePath = [self saveToLocalSendbox:picker withInfo:info];
    
    if(filePath !=nil && filePath.length > 0){
        NSMutableDictionary* retData = [NSMutableDictionary dictionary];
        [retData setObject:filePath forKey:@"filePath"];
        [self resolve:retData];
    }else{
        [self reject:ERROR_CODE_NOT_EXIST_FILE message:@"not found file path" data:nil];
    }
    
    [_imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma file
-(NSString*)saveToLocalSendbox:(UIImagePickerController*)picker withInfo:(NSDictionary*)info {
    
    [self creatPhotoDirectory];
    
    //찰영 후 원본 라이브러리에 저장
    NSURL *localUrl = (NSURL*)[info valueForKey:UIImagePickerControllerReferenceURL];
    NSLog(@"localURL:%@",[localUrl absoluteString]);
    
    NSURL *imagePath = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSString *imageExt;
    if([[imagePath lastPathComponent] pathExtension]==nil){
        imageExt=@"jpg";
    }else{
        imageExt=[[imagePath lastPathComponent] pathExtension];
    }
    
    UIImage *scaledImage = nil;
    if ( self.iWidth > 0 && self.iHeight > 0){
        scaledImage = [self imageByScalingAndCroppingForSize:[info objectForKey:@"UIImagePickerControllerOriginalImage"]
                                                      toSize:CGSizeMake(self.iWidth, self.iHeight)];
    }
    
    //이미지 퀄러티 조정
    NSData * imageData = UIImageJPEGRepresentation(scaledImage == nil ? [info objectForKey:@"UIImagePickerControllerOriginalImage"] : scaledImage, self.iQuality/100.0f);
    
    //내로컬 경로에 저장
    NSString* filePath;
    NSString* docsPath = [self getPhotoPath];
    NSError* err = nil;
    NSFileManager* fileMgr = [[NSFileManager alloc] init];
    
    int i=1;
    do {
        filePath = [NSString stringWithFormat:@"%@/%@/photo_%05d.%@", docsPath, PHOTO_FOLDER,i++,imageExt];
    } while([fileMgr fileExistsAtPath: filePath]);
    
    // save file
    if (![imageData writeToFile: filePath options: NSAtomicWrite error: &err]){
        //기록 실패
        NSLog(@"사진 이미파일 기록 실패");
    }
    
    return filePath;
}

-(NSString*)getPhotoPath {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [dirs objectAtIndex:0];
    return path;
}

- (UIImage*)imageByScalingAndCroppingForSize:(UIImage*)anImage toSize:(CGSize)targetSize
{
    UIImage *sourceImage = anImage;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor){
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    
    CGRect resizeRect = CGRectMake(0,0,scaledWidth,scaledHeight);
    
    UIGraphicsBeginImageContext( resizeRect.size ); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:resizeRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(newImage);
    UIImage *img=[UIImage imageWithData:imageData];
    
    return img;
}


- (BOOL)creatPhotoDirectory
{
    NSString *documentsDirectory = [self getPhotoPath];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:PHOTO_FOLDER];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
    return TRUE;
}

@end

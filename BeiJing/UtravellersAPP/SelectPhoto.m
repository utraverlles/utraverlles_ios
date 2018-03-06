//
//  MsgView1.m
//  FootBall3
//
//  Created by 王登鹏 on 15/10/23.
//  Copyright © 2015年 王登鹏. All rights reserved.
//
#import "SelectPhoto.h"
@interface SelectPhoto ()
@end
@implementation SelectPhoto
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler: ^(UIAlertAction *action) {
	    [self.view removeFromSuperview];
	}];
	UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
	    if ([self isCameraAvailable] && ([self isFrontCameraAvailable] || [self isRearCameraAvailable])) {
	        NSLog(@"支持相机");
	        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
            [controller setCameraDevice:UIImagePickerControllerCameraDeviceFront];
	        controller.delegate = self;// 设置代理
	        controller.allowsEditing = YES;
	        [self.navigationController presentViewController:controller animated:YES completion:nil];
	        [self.view removeFromSuperview];
		}
	}];
	UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) {
	    //从相册
	    if ([self isPhotoLibraryAvailable]) {
	        NSLog(@"支持相片库");
	        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
	        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
	        controller.delegate = self;// 设置代理
	        controller.allowsEditing = YES;
	        [self.navigationController presentViewController:controller animated:YES completion:nil];
	        [self.view removeFromSuperview];
		}
	}];
	[alertController addAction:cancelAction];
	[alertController addAction:deleteAction];
	[alertController addAction:archiveAction];
	[self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
   #pragma mark - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
   }
 */
#pragma mark - 摄像头和相册相关的公共类
// 判断设备是否有摄像头
- (BOOL)isCameraAvailable {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

// 前面的摄像头是否可用
- (BOOL)isFrontCameraAvailable {
	return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

// 后面的摄像头是否可用
- (BOOL)isRearCameraAvailable {
	return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

// 相册是否可用
- (BOOL)isPhotoLibraryAvailable {
	return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

#pragma mark - UIImagePickerControllerDelegate 代理方法
// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void)imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo {
	if (paramError == nil) {
		NSLog(@"Image was saved successfully.");
	}
	else {
		NSLog(@"An error happened while saving the image.");
		NSLog(@"Error = %@", paramError);
	}
}

// 当得到照片或者视频后，调用该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	//NSLog(@"Picker returned successfully.");
	//NSLog(@"%@", info);
	UIImage *theImage = nil;
	// 判断，图片是否允许修改
	if ([picker allowsEditing]) {
		//获取用户编辑之后的图像
		theImage = [info objectForKey:UIImagePickerControllerEditedImage];
	}
	else {
		// 照片的元数据参数
		theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	}
	// 保存图片到相册中
	[self.delegate changePhotos:theImage];
	[picker dismissViewControllerAnimated:YES completion:nil];
}

// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}

@end

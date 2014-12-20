//
//  nuevaHistoriaViewController.m
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import "nuevaHistoriaViewController.h"

@interface nuevaHistoriaViewController ()

@end

@implementation nuevaHistoriaViewController

@synthesize imageView, imagenResult, responseData, desc;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)TakePicture{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
    [self presentModalViewController: picker animated:YES];
    
    
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imagenResult = chosenImage;
    
    self.imageView.image = imagenResult;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    publicarBtn.enabled = YES;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)publicarFoto:(id)sender {
    NSData *imageData = UIImageJPEGRepresentation(imagenResult,90);     //change Image to NSData
    
    if (imageData != nil)
    {
        
        /*
         turning the image into a NSData object
         getting the image back out of the UIImageView
         setting the quality to 90
         */
        // setting up the URL to post to
        NSString *urlString = [NSString stringWithFormat:@"%@/historias/%@/nueva?desc=%@",app().urlServicio, app().userid, desc.text];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:
                                NSASCIIStringEncoding];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString]];
        [request setHTTPMethod:@"POST"];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"foto\"; filename=\"ipodfile.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setHTTPBody:body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"heyo %@", returnString);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                        message:@"Gracias por compartir su foto, en breve estará disponible.."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        desc.text = @"";
        
    }
    
}

- (IBAction)tomarFoto:(id)sender{
    [self TakePicture];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

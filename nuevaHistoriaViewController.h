//
//  nuevaHistoriaViewController.h
//  Deporte Appcesible
//
//  Created by Paola andrea Poveda vargas on 6/11/14.
//  Copyright (c) 2014 Fox Digital Studio SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nuevaHistoriaViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    BOOL doImagePicker;
    __weak IBOutlet UIButton *publicarBtn;
}
- (IBAction)tomarFoto:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextView *desc;


@property (nonatomic) UIImage *imagenResult;
@property (strong, nonatomic) NSMutableData *responseData;

@end

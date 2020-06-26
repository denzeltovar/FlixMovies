//
//  DetailsViewController.m
//  Flix
//
//  Created by denzeltov on 6/25/20.
//  Copyright © 2020 Denzel Tovar. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"



@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
       NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
       
       NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
    

    NSString *backdropURLString = self.movie[@"backdrop_path"];
       NSString *fullBackdropPosterURLString = [baseURLString stringByAppendingString: backdropURLString];
       
       NSURL *backdropURL = [NSURL URLWithString:fullBackdropPosterURLString];
    [self.backdropView setImageWithURL:backdropURL];
    
    self.titleLabel.text = self.movie[@"title"];
    self.summaryLabel.text = self.movie[@"overview"];
    
    [self.titleLabel sizeToFit];
    [self.summaryLabel sizeToFit];
    
    [self.activityIndicator startAnimating];
    [self.activityIndicator stopAnimating];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Networking Error"
           message:@"Could not connect to Network. Press OK to try again"
    preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    
    [alert addAction:cancelAction];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK \" OK" 
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
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

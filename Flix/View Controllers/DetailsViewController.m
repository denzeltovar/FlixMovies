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
}

@end

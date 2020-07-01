//
//  CollectionsViewController.m
//  Flix
//
//  Created by denzeltov on 6/26/20.
//  Copyright © 2020 Denzel Tovar. All rights reserved.
//

#import "CollectionsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface CollectionsViewController ()
//Outlets for CollectionsViewConroller
@property (weak, nonatomic) IBOutlet UIImageView *colBackdropView;
@property (weak, nonatomic) IBOutlet UIImageView *colPosterView;
@property (weak, nonatomic) IBOutlet UILabel *colTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *colSummaryLabel;

@end

@implementation CollectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.colPosterView setImageWithURL:posterURL];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString: backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    [self.colBackdropView setImageWithURL:backdropURL];
    
    self.colTitleLabel.text = self.movie[@"title"];
    self.colSummaryLabel.text = self.movie[@"overview"];
    
    [self.colTitleLabel sizeToFit];
    [self.colSummaryLabel sizeToFit];
}


@end

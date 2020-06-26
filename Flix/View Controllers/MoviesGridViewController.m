//
//  MoviesGridViewController.m
//  Flix
//
//  Created by denzeltov on 6/26/20.
//  Copyright © 2020 Denzel Tovar. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"


@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionsView;

@end

@implementation MoviesGridViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionsView.dataSource = self;
    self.collectionsView.delegate = self;
    
    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionsView.collectionViewLayout;
    
    CGFloat posterPerLine = 3;
    CGFloat itemWidth = self.collectionsView.frame.size.width / posterPerLine;
    CGFloat itemHeight = itemWidth *1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

-(void)fetchMovies {
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error != nil) {
                   NSLog(@"%@", [error localizedDescription]);
            
               }
               else {
                   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                   NSLog(@"%@" , dataDictionary);
                   
                   self.movies = dataDictionary[@"results"];
                   [self.collectionsView reloadData];
               }
        
        
           }];
        [task resume];
        
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
       NSString *posterURLString = movie[@"poster_path"];
       NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
       
       NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
       cell.posterView.image = nil;
       [cell.posterView setImageWithURL:posterURL];
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
    
}
@end

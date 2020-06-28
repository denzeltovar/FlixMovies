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
#import "CollectionsViewController.h"

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
    
    //Customizion of how the cells will be displayed on screen
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
            //Make sure to add navigation error message to all view controller**
            //Also refresh controller**
            
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



#pragma mark - Navigation

// Creating a segue from MoviesFridViewController to CollectionsViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Make sure to link to correct subclass**
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionsView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.item];
    
    CollectionsViewController *collectionsViewController= [segue destinationViewController];
    collectionsViewController.movie = movie;
}

//UICOllectionViewCell instead of UITableViewCell
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
//returning the amount of cells that needs to be created
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
    
}
@end

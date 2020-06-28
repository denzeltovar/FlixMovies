//
//  MoviesViewController.m
//  Flix
//
//  Created by admin on 6/24/20.
//  Copyright © 2020 Denzel Tovar. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
//dowloaded library thats adss aditional methods
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
//UITTableVIewDataSource- Shows table view contents (2 req)
//UITableViewDelegate- respond to table view events
@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

//Encapsulates the variable and sets getter & setter methods
//create outlet so we can refer to table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//strong- increment retain count of variable
@property (nonatomic, strong) NSArray *movies;
@property(nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController
//Function is called automatically when opened
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchMovies];
    
    //attaches refreshh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    //Function that inserts refresh control at index[0](Top)
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    //[self.tableView addSubview: self.refreshControl];
    
    
}
//Function used to retrieve info from database
-(void)fetchMovies {
    //Making a Network Call to retrieve info from datbase
    //Runs when network request comes back
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            //If can't connect to Network then display alert message
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Networking Error"
                                                                           message:@"Could not connect to Network. Press \"OK\" to try again"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                
            }];
        
            [alert addAction:cancelAction];
            
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
               
            }];
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"%@" , dataDictionary);
            //inside the [] are keys to the "movie" dictionary to acess
            //the database values.
            //"self." - set as property of the class instead of local var
            self.movies = dataDictionary[@"results"];
            for (NSDictionary *movie in self.movies) {
                NSLog(@"%@", movie[@"title"]);
            }
            //Calls data source methods again
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
        
    }];
    [task resume];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Returns amount of rows we have
    return self.movies.count;
}

//UITableViewCell- creates and configures cell
//Loads cell once it is available - Also recycles cells
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier: @"MovieCell"];
    //Accesses movie of interest using key[] and returns value
    NSDictionary *movie = self.movies[indexPath.row];
    cell.titleLabel.text = movie[@"title"];
    cell.summaryLabel.text = movie[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    //partial path to poster image
    NSString *posterURLString = movie[@"poster_path"];
    //forms full url by appending posterURLString to baseURLString
    NSString *fullPosterURLString = [baseURLString stringByAppendingString: posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.image = nil;
    [cell.posterView setImageWithURL:posterURL];
    
    return cell;
}



#pragma mark - Navigation

//called when you tap on a cell to transition to Details view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexpath =[self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexpath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    
}


@end

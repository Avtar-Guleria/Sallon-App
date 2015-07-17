//
//  MapViewController.m
//  
//




#import "MapViewController.h"
#import "MKAnnotationView+WebCache.h"

@implementation MKMapView (ZoomLevel)

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated {
    MKCoordinateSpan span = MKCoordinateSpanMake(0, 360/pow(2, zoomLevel)*self.frame.size.width/256);
    [self setRegion:MKCoordinateRegionMake(centerCoordinate, span) animated:animated];
}


-(double) getZoomLevel {
    return log2(360 * ((self.frame.size.width/256) / self.region.span.longitudeDelta));
}

@end

@interface MapViewController() {

@private

}

@property (strong, nonatomic) IBOutlet UIView *callOutView;



-(void)zoomToFitMapAnnotations:(MKMapView*)mv;
-(UIImage*)scaleImage:(UIImage*)imageToScale  toSize:(CGSize)size;


@end


@implementation MapViewController

@synthesize mapPinTitle,mapPinSubTitle,userCurrentLocationCoordinate,embassyCoordinate,mapView,isCurrentLocationNeeded;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"locationServicesEnabled false");
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    } else {
        CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
        if(authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
            NSLog(@"authorizationStatus failed");
        } else {
            NSLog(@"authorizationStatus authorized");
            locationManager = [[CLLocationManager alloc] init];
            if(([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)) {
                [locationManager requestAlwaysAuthorization];
            }
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager.distanceFilter = kCLDistanceFilterNone;
            [locationManager startUpdatingLocation];
        }
    }
    
    [self.mapView setDelegate:self];
    
    [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    mapView=nil;
}


#pragma mark-Get Direction Action sheet
- (IBAction)showDirectionActionSheet:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Open in Maps for Direction?"
                                                             delegate:self 
                                                    cancelButtonTitle:@"Cancel"
                                  
                                               destructiveButtonTitle:@"Open in Maps"
                                                    otherButtonTitles:nil ,nil];
    
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
    
    // Display the action sheet from tabbar
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        
        return; 
    }
    
    else  {
        
        [self getDirectionOnMap:userCurrentLocationCoordinate toCoordinate:embassyCoordinate];
        
    }
}


#pragma mark - Get Direction
-(void)getDirectionOnMap:(CLLocationCoordinate2D)fromCoordinate toCoordinate:(CLLocationCoordinate2D)toCoordinate
{
    NSString* url = [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f",
                     fromCoordinate.latitude, fromCoordinate.longitude,toCoordinate.latitude, toCoordinate.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}


#pragma mark- CLLocation Delegates.

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [locationManager stopUpdatingLocation];
    
    userCurrentLocationCoordinate = newLocation.coordinate;

    if(isCurrentLocationNeeded){
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userCurrentLocationCoordinate, 800, 800);
        //send this property to true if user current location needed.
        [self.mapView setShowsUserLocation:isCurrentLocationNeeded];
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}


#pragma mark- MapView Delegates.

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{    
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{

}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
   
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"Location";   
    
    if ([annotation isKindOfClass:[Location class]]) {
        
        //get reusable map view pin if available.
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
       
        
        //if pin/annotation is nil. create a new one
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];	
        } else {
            annotationView.annotation = annotation;
        }

        //check for custom map pin.
        NSString * mapPinImage=((Location*)annotation).mapPinImageName;
        NSString * mapPinUrl=((Location*)annotation).mapPinUrl;
        
        NSLog(@"Map Pin Image=%@",mapPinImage);
        
        
        if(mapPinImage){
        //set Map pin Image.
            UIImage *pinImage=[UIImage imageNamed:mapPinImage];
            pinImage=[self scaleImage:pinImage toSize:CGSizeMake(40, 40)];            
            annotationView.image=pinImage;
        
        }else if(mapPinUrl){
            //download image using sdwebcache.h library and resize and restore it.
            [annotationView sd_setImageWithURL:[NSURL URLWithString:mapPinUrl] placeholderImage:[UIImage imageNamed:@"mapPin.jpg"]];
//            [annotationView setImageWithURL:[NSURL URLWithString:mapPinUrl] placeholderImage:[UIImage imageNamed:@"mapPin.jpg"] withSize:CGSizeMake(40, 40)];
        
        }else{
            //set defaul red color pin.
            annotationView.pinColor = MKPinAnnotationColorRed;
            annotationView.enabled = YES;
            annotationView.animatesDrop = YES;
            
        }
        
        annotationView.canShowCallout = YES;
   
        
        //custom view on Map Pin

        [self addCustomCallOutView:annotationView];
        
        
        return annotationView;
    }else{
        
        //show user location.
          MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        //set defaul red color pin.
        annotationView.pinColor = MKPinAnnotationColorPurple;
        annotationView.enabled = YES;
        annotationView.animatesDrop = YES;

        return annotationView;
        
    }
        
       
   
    return nil;
}


-(void)addCustomCallOutView:(MKPinAnnotationView*)view{
    // create a little accessory view to mimic the little car that Maps.app shows
   
    
    // wrap it in a blue background on iOS 7+
    UIButton *blueView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44+30)];
    blueView.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:1 alpha:1];
    [blueView addTarget:self action:@selector(carClicked) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *carView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Driving"]];
    carView.frame = CGRectMake(11, 10, carView.image.size.width, carView.image.size.height);
    [blueView addSubview:carView];
    
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(8, carView.image.size.height+15, 44-12, 12)];
    label.text=@"5 min";
    label.textColor=[UIColor whiteColor];
    label.font=[UIFont boldSystemFontOfSize:12.0];
    [blueView addSubview:label];
    
    view.leftCalloutAccessoryView= blueView;
    
    //    // create a little disclosure indicator since our callout is tappable
    //    UIButton *disclosure = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //    [disclosure addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disclosureTapped)]];
    //    self.calloutView.rightAccessoryView = disclosure;
    //
    //
    view.rightCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UITableNext"]];
    view.rightCalloutAccessoryView.alpha = 0.2;

    
    
}

-(void)carClicked{
    [self performSegueWithIdentifier:@"viewOrder" sender:self];
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
//    self.embassyCoordinate=((Location*)view.annotation).coordinate;
//    
//    [self showDirectionActionSheet:nil];
}





#pragma mark- Custom BL methods
- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle {
    
    if(!pinTitle){
        mapPinTitle=@"";
    }else{
        mapPinTitle=pinTitle;
    }
    Location *annotation = [[Location alloc] initWithName:mapPinTitle address:nil coordinate:coordinate];
      
    [self.mapView addAnnotation:annotation];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate ,100,100);
    [self.mapView setRegion:region animated:YES];
  
}


- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle mapPinImage:(NSString *)imageName{
    
    if(!pinTitle){
        mapPinTitle=@"";
    }else{
        mapPinTitle=pinTitle;
    }
    
    Location *annotation = [[Location alloc] initWithName:mapPinTitle address:nil coordinate:coordinate];
    
    annotation.mapPinImageName=imageName;
    
    [self.mapView addAnnotation:annotation];  
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate ,800,800);
    [self.mapView setRegion:region animated:YES];
    
}



- (void)plotPositionWithCordinate:(CLLocationCoordinate2D)coordinate withPinTitle:(NSString*)pinTitle mapPinImageUrl:(NSString *)imageUrl{
    
    if(!pinTitle){
        mapPinTitle=@"";
    }else{
        mapPinTitle=pinTitle;
    }
    
    Location *annotation = [[Location alloc] initWithName:mapPinTitle address:nil coordinate:coordinate];
    
    annotation.mapPinUrl=imageUrl;
    
    [self.mapView addAnnotation:annotation];  
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate ,800,800);
    [self.mapView setRegion:region animated:YES];
    
}




-(void)plotCordinates:(NSMutableArray*)locations
{
    
    //plot multiple pins at once.
    [self.mapView addAnnotations:locations];
    
    //set zoom level for the mapview.
    [self zoomToFitMapAnnotations:self.mapView];

}


- (void)showUserLocationToCenter
{
    [self.mapView setCenterCoordinate:userCurrentLocationCoordinate animated:YES];
    
}


-(void)zoomToFitMapAnnotations:(MKMapView*)mv
{
    //NSLog(@"zoom To Fit Map Annotations");
    if([mv.annotations count] == 0)
        return;
    
    if([mv.annotations count] == 1) {
        
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta=0.2;
        span.longitudeDelta=0.2;
        
        for(Location* annotation in mv.annotations){
            
            CLLocationCoordinate2D location;
            location.latitude = annotation.coordinate.latitude;
            location.longitude = annotation.coordinate.longitude;
            region.span=span;
            region.center=location;
            
            [mv setRegion:region animated:TRUE];
            [mv regionThatFits:region];
            
        }
        
        
    }else {
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        topLeftCoord.longitude = 180;
        
        CLLocationCoordinate2D bottomRightCoord;
        bottomRightCoord.latitude = 90;
        bottomRightCoord.longitude = -180;
        
        for(Location* annotation in mv.annotations)
        {
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
        }
        
        MKCoordinateRegion region;
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; // Add a little extra space on the sides
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; // Add a little extra space on the sides
        
        region = [mv regionThatFits:region];
        [mv setRegion:region animated:YES];
        
    }
    
}


#pragma mark- Util Methods.


-(UIImage*)scaleImage:(UIImage*)imageToScale  toSize:(CGSize)size
{
    // Create a bitmap graphics context
    // This will also set it as the current context
    UIGraphicsBeginImageContext(size);
    
    // Draw the scaled image in the current context
    [ imageToScale drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // Create a new image from current context
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Pop the current context from the stack
    UIGraphicsEndImageContext();
    
    // Return our new scaled image
    return scaledImage;
}








@end

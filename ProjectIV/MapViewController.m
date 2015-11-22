//
//  MapViewController.m
//  
//
//  Created by Irwin Gonzales on 11/19/15.
//
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <CLLocationManagerDelegate>

@property CLLocationManager *locationManager;
@property CLLocation *currentLocation;
@property CLLocationCoordinate2D locationCoordiante;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//------------------------- LOCATION MANAGEMENT ----------------------

#pragma
#pragma mark - Setup Location Manager
- (void)setupLocationManager
{
    // Pre-check for authorizations
    if (![CLLocationManager locationServicesEnabled])
    {
        NSLog(@"location services are disabled");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        NSLog(@"location services are blocked by the user");
        return;
    }
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        NSLog(@"about to show a dialog requesting permission");
    }

    // Create LocationManager
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;

    // Request user authorization
    [self.locationManager requestWhenInUseAuthorization];

    /* Pinpoint our location with the following accuracy:
     *
     *     kCLLocationAccuracyBestForNavigation  highest + sensor data
     *     kCLLocationAccuracyBest               highest
     *     kCLLocationAccuracyNearestTenMeters   10 meters
     *     kCLLocationAccuracyHundredMeters      100 meters
     *     kCLLocationAccuracyKilometer          1000 meters
     *     kCLLocationAccuracyThreeKilometers    3000 meters
     */
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    /* Notify changes when device has moved x meters.
     * Default value is kCLDistanceFilterNone: all movements are reported.
     */
    self.locationManager.distanceFilter = 10.0f;

    /* Notify heading changes when heading is > 5.
     * Default value is kCLHeadingFilterNone: all movements are reported.
     */
    self.locationManager.headingFilter = 5;
}

#pragma
#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocationCoordinate2D myLocation = [locations.firstObject coordinate];
    self.locationCoordiante = myLocation;

    // Set phones current location
    self.currentLocation = locations.lastObject;

    if (self.currentLocation != nil)
    {
        // Stop updating location
        [self.locationManager stopUpdatingLocation];

        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.locationCoordiante.latitude longitude:self.locationCoordiante.longitude];
        [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
        [[PFUser currentUser] saveInBackground];
    }
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

@end

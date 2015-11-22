//
//  MaybeUseLater.m
//  
//
//  Created by Irwin Gonzales on 11/20/15.
//
//

#import "MaybeUseLater.h"

@implementation MaybeUseLater

//- (void)zoomToSchool
//{
//    NSString *location = @"some address, state, and zip";
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    [geocoder geocodeAddressString:location
//                 completionHandler:^(NSArray* placemarks, NSError* error){
//                     if (placemarks && placemarks.count > 0) {
//                         CLPlacemark *topResult = [placemarks objectAtIndex:0];
//                         MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
//
//                         MKCoordinateRegion region = self.map.region;
//                         region.span.longitudeDelta /= 8.0;
//                         region.span.latitudeDelta /= 8.0;
//
//                         [self.map setRegion:region animated:YES];
//                         [self.map addAnnotation:placemark];
//                     }
//                 }
//     ];
//}

//-(MKAnnotationView *)map:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    MKAnnotationView *pin = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:nil];
//
//    pin.canShowCallout = YES;
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    [rightButton setTitle:@"Fuck Yeah" forState:UIControlStateNormal];
//    rightButton.tintColor = [UIColor redColor];
//    [pin setRightCalloutAccessoryView:rightButton];
//    return pin;
//}

//#pragma
//#pragma mark - Login Button Style
//- (void)signupButtonStyle
//{
//    self.signupButton.buttonColor = [UIColor turquoiseColor];
//    self.signupButton.shadowColor = [UIColor greenSeaColor];
//    self.signupButton.shadowHeight = 3.0f;
//    self.signupButton.cornerRadius = 6.0f;
//    self.signupButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
//    [self.signupButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
//    [self.signupButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
//}


@end

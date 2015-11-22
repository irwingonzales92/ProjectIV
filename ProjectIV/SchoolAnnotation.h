//
//  SchoolAnnotation.h
//  
//
//  Created by Irwin Gonzales on 11/20/15.
//
//

#import <MapKit/MapKit.h>
#import "School.h"

@interface SchoolAnnotation : MKPointAnnotation

@property School *school;

@end

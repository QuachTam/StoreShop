//
//  Base.h
//  StoreManager
//
//  Created by ATam on 12/27/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Base : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * uuid;

@end

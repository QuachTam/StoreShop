//
//  NSManagedObject+VC.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 11/24/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (VC)
+ (instancetype)entityWithUuid:(NSString *)uuid inContext:(NSManagedObjectContext *)context;
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offset:(NSUInteger)offset limit:(NSUInteger)limit inContext:(NSManagedObjectContext *)context;
+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context;
//+ (NSArray *) entitiesWithUuidArray:(NSArray *)array inContext:(NSManagedObjectContext *)context;
@end

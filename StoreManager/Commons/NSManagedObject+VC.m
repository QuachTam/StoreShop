//
//  NSManagedObject+VC.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 11/24/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "NSManagedObject+VC.h"

static NSString *VCUUID = @"syncID";

@implementation NSManagedObject (VC)

+ (instancetype)entityWithUuid:(NSString *)uuid inContext:(NSManagedObjectContext *)context {
    if (!uuid || uuid == (id)[NSNull null] || uuid.length == 0) {
        return nil;
    }
    id object = [[self class] MR_findFirstByAttribute:VCUUID withValue:uuid inContext:context];
    if (!object) {
        object = [[self class] MR_createEntityInContext:context];
        [object setValue:uuid forKey:VCUUID];
        [object setValue:[NSDate date] forKey:@"dateCreate"];
    }
    return object;
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors offset:(NSUInteger)offset limit:(NSUInteger)limit inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest* request = [self MR_createFetchRequestInContext:context];
    if (sortDescriptors && [sortDescriptors count] > 0) {
        [request setSortDescriptors:sortDescriptors];
    }
    [request setPredicate:predicate];
    
    request.fetchOffset = offset;
    request.fetchLimit = limit;
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest:request error:&error];
    assert(error == nil);
    return result;
}

+ (NSArray *)findWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors inContext:(NSManagedObjectContext *)context
{
    NSFetchRequest* request = [self MR_createFetchRequestInContext:context];
    if (sortDescriptors && [sortDescriptors count] > 0) {
        [request setSortDescriptors:sortDescriptors];
    }
    [request setPredicate:predicate];
    
    NSError* error = nil;
    NSArray* result = [context executeFetchRequest:request error:&error];
    assert(error == nil);
    return result;
}
/*
+ (NSArray *)entitiesWithUuidArray:(NSArray *)array inContext:(NSManagedObjectContext *)context
{
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"ANY %@ IN %@", VCUUID, array];
    NSArray * existedList = [[self class] MR_findAllWithPredicate:predicate inContext:context];
    NSMutableArray * remainUUIDList = [NSMutableArray new];
    for (NSString * object1 in array) {
        BOOL found = NO;
        for (id object2 in existedList) {
            if ([object1 isEqualToString:[object2 uuid]]) {
                found = YES;
                break;
            }
        }
        if (!found) {
            [remainUUIDList addObject:object1];
        }
    }
    NSMutableArray * objectList = [NSMutableArray arrayWithArray:existedList];
    for (NSString * uuid in remainUUIDList) {
        id object = [[self class] MR_createInContext:context];
        [object setValue:uuid forKey:VCUUID];
        [objectList addObject:object];
    }
    
    return objectList;
}*/
@end

//
//  ItemService.h
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MagicalRecord/MagicalRecord.h>
#import "ModelItem.h"
#import "Item.h"

@interface ItemService : NSObject <NSFetchedResultsControllerDelegate>
@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

- (id)fetchModelAtIndexPath:(NSIndexPath*)indexPath;
- (id)findModelWithQrcode:(NSString*)qrcode;
- (void)updateItemForSell:(ModelItem*)item success:(void(^)(void))success;
- (void)deleteItemWithModel:(ModelItem *)item success:(void(^)(void))success;

@property (nonatomic, copy, readwrite) void(^beginUpdates)();
@property (nonatomic, copy, readwrite) void(^endUpdates)();
@property (nonatomic, copy, readwrite) void(^insertSections)(NSUInteger sectionIndex);
@property (nonatomic, copy, readwrite) void(^deleteSections)(NSUInteger sectionIndex);
@property (nonatomic, copy, readwrite) void(^insertRowsAtIndexPaths)(NSArray *newIndexPath);
@property (nonatomic, copy, readwrite) void(^deleteRowsAtIndexPaths)(NSArray *indexPath);
@property (nonatomic, copy, readwrite) void(^changeUpdate)(NSIndexPath *indexPath);
@end

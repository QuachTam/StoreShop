//
//  ItemService.m
//  StoreManager
//
//  Created by ATam on 12/24/15.
//  Copyright (c) 2015 ATam. All rights reserved.
//

#import "ItemService.h"
#import "Qrcode.h"

@implementation ItemService
@synthesize fetchedResultsController = _fetchedResultsController;

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [NSManagedObjectContext MR_defaultContext];
    }
    return _managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"dateCreate" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    [fetchRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:@"Root"];
    
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;

    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    if (self.beginUpdates) {
        self.beginUpdates();
    }
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            if (self.insertSections) {
                self.insertSections(sectionIndex);
            }
            break;
        case NSFetchedResultsChangeDelete:
            if (self.deleteSections) {
                self.deleteSections(sectionIndex);
            }
            break;
        case NSFetchedResultsChangeMove:
        case NSFetchedResultsChangeUpdate:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            if (self.insertRowsAtIndexPaths) {
                self.insertRowsAtIndexPaths(@[newIndexPath]);
            }
            break;
        case NSFetchedResultsChangeDelete:
            if (self.deleteRowsAtIndexPaths) {
                self.deleteRowsAtIndexPaths(@[indexPath]);
            }
            break;
        case NSFetchedResultsChangeUpdate:
            if (self.changeUpdate) {
                self.changeUpdate(indexPath);
            }
            break;
        case NSFetchedResultsChangeMove:
            if (self.deleteRowsAtIndexPaths) {
                self.deleteRowsAtIndexPaths(@[indexPath]);
            }
            if (self.insertRowsAtIndexPaths) {
                self.insertRowsAtIndexPaths(@[newIndexPath]);
            }
            break;
    }
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (self.endUpdates) {
        self.endUpdates();
    }
}

- (id)fetchModelAtIndexPath:(NSIndexPath*)indexPath {
    id object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    ModelItem *model = [[ModelItem alloc] initWithEntity:object];
    return model;
}

- (id)findModelWithQrcode:(NSString*)qrcode {
    Qrcode *entityCurrent = nil;
    NSArray *qrcodeEntitys = [Qrcode MR_findAllInContext:[NSManagedObjectContext MR_defaultContext]];
    for (NSInteger index=0; index<qrcodeEntitys.count; index++) {
        Qrcode *entity = [qrcodeEntitys objectAtIndex:index];
        if ([entity.name isEqualToString:qrcode]) {
            entityCurrent = entity;
            break;
        }
    }
    ModelItem *model = nil;
    if (entityCurrent) {
        model = [[ModelItem alloc] initWithEntity:entityCurrent.item];
    }else{
        model = [[ModelItem alloc] init];
    }
    return model;
}

- (void)updateItemForSell:(ModelItem*)item success:(void(^)(void))success{
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        NSPredicate *prediate = [NSPredicate predicateWithFormat:@"syncID=%@", item.syncID];
        Item *entity = [Item MR_findFirstWithPredicate:prediate inContext:localContext];
        entity.isSell = @(1);
    }];
}

- (void)deleteItemWithModel:(ModelItem *)item success:(void (^)(void))success {
    [MagicalRecord saveWithBlockAndWait:^(NSManagedObjectContext *localContext) {
        Item *entity = [Item entityWithUuid:item.syncID inContext:localContext];
        [entity MR_deleteEntityInContext:localContext];
    }];
    if (success) {
        success();
    }
}

@end

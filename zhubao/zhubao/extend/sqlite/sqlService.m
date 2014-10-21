//
//  sqlService.m
//  ACS
//
//  Created by 陈 星 on 13-5-2.
//
//

#import "sqlService.h"

@implementation sqlService

@synthesize _database;

- (id)init
{
    return self;
}

- (void)dealloc
{
    //[super dealloc]; 
}

//将根目录下面的数据库文件复制到sqlite的指定目录下面
-(BOOL)initializeDb{
    
	//NSLog(@"initializeDB");
    
	//look to see if DB is in known location (~/Documents/$DATABASE_FILE_NAME)
	//START:code.DatabaseShoppingList.findDocumentsDirectory
	NSArray*searchPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
	NSString * documentFolderPath=[searchPaths objectAtIndex:0];
    
	//查看文件目录
    
	NSLog(@"查看文件目录:%@",documentFolderPath);
    
	NSString * dbFilePath=[documentFolderPath stringByAppendingPathComponent:kFileallname];
    
	//END:code.DatabaseShoppingList.findDocumentsDirectory
    
    //[dbFilePath retain];
    
    //START:code.DatabaseShoppingList.copyDatabaseFileToDocuments
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:dbFilePath]){
        
        //didn't find db,need to copy
        
        NSString*backupDbPath=[[NSBundle mainBundle]pathForResource:kfilename ofType:kfiletype];
        
        if(backupDbPath==nil){
            
            //couldn't find backup db to copy,bail
            
            return NO;
            
        }else{
            
            BOOL copiedBackupDb=[[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:dbFilePath error:nil];
            
            if(!copiedBackupDb){
                
                //copying backup db failed,bail
                
                return NO;
                
            }
            //NSLog(@"数据库拷贝成功");
        }
        
    }
    
    //NSLog(@"bottomo finitialize Db");
    
    return YES;
    
    //END:code.DatabaseShoppingList.copyDatabaseFileToDocuments
}

//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"=======%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFileallname];//这里很神奇，可以定义成任何类型的文件，也可以不定义成.db文件，任何格式都行，定义成.sb文件都行，达到了很好的数据隐秘性
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //如果数据库已经打开了，则直接返回
    if(_database)return TRUE;
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    
    //NSLog(@"%@",path);
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    if (find) {
        
        //NSLog(@"Database file have already existed.");
        
        //打开数据库，这里的[path UTF8String]是将NSString转换为C字符串，因为SQLite3是采用可移植的C(而不是
        //Objective-C)编写的，它不知道什么是NSString.
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
            //NSLog(@"Error: open database file.");
            return NO;
        }
        
        return YES;
    }
    
    return NO;
}




//直接执行sql方法，比如修改，删除，插入的操作
-(BOOL)HandleSql:(NSString *)sql
{
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        const char *sqlT = [sql UTF8String];
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sqlT, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: SQL语句 failed to HandleSql:%@",sql);
            sqlite3_close(_database);
            return NO;
        }
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: 执行失败 HandleSql:%@",sql);
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//此方法不关闭数据库，要手动关闭调方法closeDB关闭
-(BOOL) execSql:(NSString *)sql {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        char *errorMsg = nil;
        
        if(SQLITE_OK != sqlite3_exec(_database, [sql UTF8String],NULL,NULL,&errorMsg))
        {
            //sqlite3_close(_database);
            
            NSLog(@"error:%@",sql);
            
            NSLog(@"error:%s",errorMsg);
            
            return NO;
        }
        
        //NSLog(@"%@",insertSql);
        
        //sqlite3_close(_database);
        
        return YES;
        
    }
    return NO;
}

//执行sql
-(BOOL) execSqlandClose:(NSString *)sql {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        char *errorMsg = nil;
        
        if(SQLITE_OK != sqlite3_exec(_database, [sql UTF8String],NULL,NULL,&errorMsg))
        {
            sqlite3_close(_database);
            
            NSLog(@"error:%@",sql);
            
            NSLog(@"error:%s",errorMsg);
            
            return NO;
        }
        
        //NSLog(@"%@",insertSql);
        
        sqlite3_close(_database);
        
        return YES;
        
    }
    return NO;
}

//关闭数据库连接
-(BOOL) closeDB
{
    @try {
        
        if(_database)sqlite3_close(_database);
        return YES;
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }

    return NO;
}

//清空数据
- (BOOL)ClearTableDatas:(NSString *)tableName{
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        //组织SQL语句
        NSString * t1 = @" delete from ";
        NSString * ts = [t1 stringByAppendingString:tableName];
        const char * sql =[ts UTF8String];
        
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            //NSLog(@"Error: failed to delete:TB_Door");
            sqlite3_close(_database);
            return NO;
        }
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            //NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//查询记录的条数
- (int)getcount:(NSString *)sqls {
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        
        const char *sql = [sqls UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return 0;
        } else {
            int row=0;
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                row++;
            }
            
            return row;
            
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return 0;
}



//以下是业务查询操作///////////////////////////////////////////////////////////////////////

//查询商品列表
- (NSMutableArray*)GetProductList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 page:(int)page pageSize:(int)pageSize{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    NSMutableString *asql=[[NSMutableString alloc] init];
    NSMutableArray *type1array=[[NSMutableArray alloc]initWithCapacity:5];
    NSInteger c=0;

    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Pro_model,Pro_number,Pro_name,Pro_State,Pro_smallpic,Pro_bigpic,Pro_info,Pro_goldWeight,Pro_author,Pro_addtime,producttype from product where Pro_IsDel='0' and producttype='0'" ];
        if (type1.length!=0) {
            NSString *classsql=@"";
            
            NSArray *t1array=[type1 componentsSeparatedByString:@","];
            [type1array addObjectsFromArray:t1array];
            for (NSString *index in t1array) {
                if ([index isEqualToString:@"10"]) {
                    if (asql.length!=0) {
                        [asql appendString:@" or "];
                        [asql appendString:@"  Pro_f_polish='true' "];
                    }else{
                        [asql appendString:@"  Pro_f_polish='true' "];
                    }
                    [type1array removeObject:index];
                    c++;
                }
                if ([index isEqualToString:@"11"]) {
                    if (asql.length!=0) {
                        [asql appendString:@" or "];
                        [asql appendString:@"  Pro_Type=2 "];
                    }else{
                        [asql appendString:@"  Pro_Type=2 "];
                    }
                    [type1array removeObject:index];
                    c++;
                }
            }
            
            NSMutableString *styleindex=[[NSMutableString alloc] init];
            for (NSString *index in type1array) {
                if (styleindex.length!=0) {
                    [styleindex appendString:@","];
                    [styleindex appendString:index];
                }else{
                    [styleindex appendString:index];
                }
            }
            
            if (styleindex.length!=0) {
                classsql=[classsql stringByAppendingString:[NSString stringWithFormat:@" and Pro_Class in (%@) ",styleindex]];
                if ([styleindex isEqualToString:@"3"]) {
                    classsql=[classsql stringByAppendingString:@" and Pro_typeWenProId=0 "];
                }
            }
            
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type2.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Pro_goldType in (%@) ",type2];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type3.length!=0) {
            NSString *classsql=nil;
            NSArray *inlayArray=[type3 componentsSeparatedByString:@","];
            for (NSString *inlay in inlayArray) {
                NSArray *inlayfff=[inlay componentsSeparatedByString:@"-"];
                if (classsql) {
                    classsql=[classsql stringByAppendingString:@" or "];
                    classsql=[classsql stringByAppendingString:[NSString stringWithFormat:@" zWeight in (%@,%@)",[inlayfff objectAtIndex:0],[inlayfff objectAtIndex:1]]];
                }else{
                    classsql=[@" and exists( select * from withmouth where withmouth.Proid=product.Id and (zWeight " stringByAppendingString:[NSString stringWithFormat:@"in (%@,%@)",[inlayfff objectAtIndex:0],[inlayfff objectAtIndex:1]]];
                }
            }
            if(classsql){
                classsql=[classsql stringByAppendingString:@"))"];
            }
            
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type4.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and %@ ",type4];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (asql.length!=0) {
            if ([type1array count]!=0) {
                if (c>1) {
                    querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" or ( %@ )",asql]];
                }else{
                    querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" or %@ ",asql]];
                }
            }else{
                if (c>1) {
                    querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" and ( %@ )",asql]];
                }else{
                    querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" and %@ ",asql]];
                }
            }
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" order by Pro_Order limit %d offset %d ",pageSize,offsetcount]];
        
        NSLog(@"querySQL-----:%@",querySQL);
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                productEntity * entity = [[productEntity alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Pro_model   = (char *)sqlite3_column_text(statement,1);
                if(Pro_model != nil)
                    entity.Pro_model = [NSString stringWithUTF8String:Pro_model];
                
                char * Pro_number   = (char *)sqlite3_column_text(statement,2);
                if(Pro_number != nil)
                    entity.Pro_number = [NSString stringWithUTF8String:Pro_number];
                
                char * Pro_name   = (char *)sqlite3_column_text(statement,3);
                if(Pro_name != nil)
                    entity.Pro_name = [NSString stringWithUTF8String:Pro_name];
                
                char * Pro_State   = (char *)sqlite3_column_text(statement,4);
                if(Pro_State != nil)
                    entity.Pro_State = [NSString stringWithUTF8String:Pro_State];
                
                char * Pro_smallpic   = (char *)sqlite3_column_text(statement,5);
                if(Pro_smallpic != nil)
                    entity.Pro_smallpic = [NSString stringWithUTF8String:Pro_smallpic];
                
                char * Pro_bigpic   = (char *)sqlite3_column_text(statement,6);
                if(Pro_bigpic != nil)
                    entity.Pro_bigpic = [NSString stringWithUTF8String:Pro_bigpic];
                
                char * Pro_info   = (char *)sqlite3_column_text(statement,7);
                if(Pro_info != nil)
                    entity.Pro_info = [NSString stringWithUTF8String:Pro_info];
                
                char * Pro_goldWeight   = (char *)sqlite3_column_text(statement,8);
                if(Pro_goldWeight != nil)
                    entity.Pro_goldWeight = [NSString stringWithUTF8String:Pro_goldWeight];
                
                char * Pro_author   = (char *)sqlite3_column_text(statement,9);
                if(Pro_author != nil)
                    entity.Pro_author = [NSString stringWithUTF8String:Pro_author];
                
                char * Pro_addtime   = (char *)sqlite3_column_text(statement,10);
                if(Pro_addtime != nil)
                    entity.Pro_addtime = [NSString stringWithUTF8String:Pro_addtime];
                
                char * producttype   = (char *)sqlite3_column_text(statement,11);
                if(producttype != nil)
                    entity.producttype = [NSString stringWithUTF8String:producttype];
                
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询商品明细
-(productEntity*)GetProductDetail:(NSString *)pid{
    
    productEntity * entity = [[productEntity alloc] init];
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Pro_model,Pro_number,Pro_name,Pro_State,Pro_smallpic,Pro_bigpic,Pro_info,Pro_goldWeight,Pro_author,Pro_Class,Pro_goldType,Pro_f_pair,Pro_hotE,Pro_Z_color,Pro_Z_weight,Pro_Z_count,Pro_f_count,Pro_f_weight,Pro_goldsize,Pro_MarketPrice,Pro_price,Pro_Type,Pro_typeWenProId,producttype from product where Id=%@ ",pid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {

                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Pro_model   = (char *)sqlite3_column_text(statement,1);
                if(Pro_model != nil)
                    entity.Pro_model = [NSString stringWithUTF8String:Pro_model];
                
                char * Pro_number   = (char *)sqlite3_column_text(statement,2);
                if(Pro_number != nil)
                    entity.Pro_number = [NSString stringWithUTF8String:Pro_number];
                
                char * Pro_name   = (char *)sqlite3_column_text(statement,3);
                if(Pro_name != nil)
                    entity.Pro_name = [NSString stringWithUTF8String:Pro_name];
                
                char * Pro_State   = (char *)sqlite3_column_text(statement,4);
                if(Pro_State != nil)
                    entity.Pro_State = [NSString stringWithUTF8String:Pro_State];
                
                char * Pro_smallpic   = (char *)sqlite3_column_text(statement,5);
                if(Pro_smallpic != nil)
                    entity.Pro_smallpic = [NSString stringWithUTF8String:Pro_smallpic];
                
                char * Pro_bigpic   = (char *)sqlite3_column_text(statement,6);
                if(Pro_bigpic != nil)
                    entity.Pro_bigpic = [NSString stringWithUTF8String:Pro_bigpic];
                
                char * Pro_info   = (char *)sqlite3_column_text(statement,7);
                if(Pro_info != nil)
                    entity.Pro_info = [NSString stringWithUTF8String:Pro_info];
                
                char * Pro_goldWeight   = (char *)sqlite3_column_text(statement,8);
                if(Pro_goldWeight != nil)
                    entity.Pro_goldWeight = [NSString stringWithUTF8String:Pro_goldWeight];
            
                char * Pro_author   = (char *)sqlite3_column_text(statement,9);
                if(Pro_author != nil)
                    entity.Pro_author = [NSString stringWithUTF8String:Pro_author];

                char * Pro_Class   = (char *)sqlite3_column_text(statement,10);
                if(Pro_Class != nil)
                    entity.Pro_Class = [NSString stringWithUTF8String:Pro_Class];

                char * Pro_goldType   = (char *)sqlite3_column_text(statement,11);
                if(Pro_goldType != nil)
                    entity.Pro_goldType = [NSString stringWithUTF8String:Pro_goldType];

                char * Pro_f_pair   = (char *)sqlite3_column_text(statement,12);
                if(Pro_f_pair != nil)
                    entity.Pro_f_pair = [NSString stringWithUTF8String:Pro_f_pair];

                char * Pro_hotE   = (char *)sqlite3_column_text(statement,13);
                if(Pro_hotE != nil)
                    entity.Pro_hotE = [NSString stringWithUTF8String:Pro_hotE];

                char * Pro_Z_color   = (char *)sqlite3_column_text(statement,14);
                if(Pro_Z_color != nil)
                    entity.Pro_Z_color = [NSString stringWithUTF8String:Pro_Z_color];

                char * Pro_Z_weight   = (char *)sqlite3_column_text(statement,15);
                if(Pro_Z_weight != nil)
                    entity.Pro_Z_weight = [NSString stringWithUTF8String:Pro_Z_weight];
                
                char * Pro_Z_count   = (char *)sqlite3_column_text(statement,16);
                if(Pro_Z_count != nil)
                    entity.Pro_Z_count = [NSString stringWithUTF8String:Pro_Z_count];
                
                char * Pro_f_count   = (char *)sqlite3_column_text(statement,17);
                if(Pro_f_count != nil)
                    entity.Pro_f_count = [NSString stringWithUTF8String:Pro_f_count];
                
                char * Pro_f_weight   = (char *)sqlite3_column_text(statement,18);
                if(Pro_f_weight != nil)
                    entity.Pro_f_weight = [NSString stringWithUTF8String:Pro_f_weight];
                
                char * Pro_goldsize   = (char *)sqlite3_column_text(statement,19);
                if(Pro_goldsize != nil)
                    entity.Pro_goldsize = [NSString stringWithUTF8String:Pro_goldsize];
                
                char * Pro_MarketPrice   = (char *)sqlite3_column_text(statement,20);
                if(Pro_MarketPrice != nil)
                    entity.Pro_MarketPrice = [NSString stringWithUTF8String:Pro_MarketPrice];
                
                char * Pro_price   = (char *)sqlite3_column_text(statement,21);
                if(Pro_price != nil)
                    entity.Pro_price = [NSString stringWithUTF8String:Pro_price];
                
                char * Pro_Type   = (char *)sqlite3_column_text(statement,22);
                if(Pro_Type != nil)
                    entity.Pro_Type = [NSString stringWithUTF8String:Pro_Type];
                
                char * Pro_typeWenProId   = (char *)sqlite3_column_text(statement,23);
                if(Pro_typeWenProId != nil)
                    entity.Pro_typeWenProId = [NSString stringWithUTF8String:Pro_typeWenProId];
                
                char * producttype   = (char *)sqlite3_column_text(statement,24);
                if(producttype != nil)
                    entity.producttype = [NSString stringWithUTF8String:producttype];
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return entity;
}

//查询商品明细
-(productEntity*)GetProductBoyDetail:(NSString *)girlid{
    
    productEntity * entity = [[productEntity alloc] init];
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Pro_model,Pro_number,Pro_name,Pro_State,Pro_smallpic,Pro_bigpic,Pro_info,Pro_goldWeight,Pro_author,Pro_Class,Pro_goldType,Pro_f_pair,Pro_hotE,Pro_Z_color,Pro_Z_weight,Pro_Z_count,Pro_f_count,Pro_f_weight,Pro_goldsize,Pro_MarketPrice,Pro_price,Pro_Type,Pro_typeWenProId from product where Pro_typeWenProId=%@ ",girlid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Pro_model   = (char *)sqlite3_column_text(statement,1);
                if(Pro_model != nil)
                    entity.Pro_model = [NSString stringWithUTF8String:Pro_model];
                
                char * Pro_number   = (char *)sqlite3_column_text(statement,2);
                if(Pro_number != nil)
                    entity.Pro_number = [NSString stringWithUTF8String:Pro_number];
                
                char * Pro_name   = (char *)sqlite3_column_text(statement,3);
                if(Pro_name != nil)
                    entity.Pro_name = [NSString stringWithUTF8String:Pro_name];
                
                char * Pro_State   = (char *)sqlite3_column_text(statement,4);
                if(Pro_State != nil)
                    entity.Pro_State = [NSString stringWithUTF8String:Pro_State];
                
                char * Pro_smallpic   = (char *)sqlite3_column_text(statement,5);
                if(Pro_smallpic != nil)
                    entity.Pro_smallpic = [NSString stringWithUTF8String:Pro_smallpic];
                
                char * Pro_bigpic   = (char *)sqlite3_column_text(statement,6);
                if(Pro_bigpic != nil)
                    entity.Pro_bigpic = [NSString stringWithUTF8String:Pro_bigpic];
                
                char * Pro_info   = (char *)sqlite3_column_text(statement,7);
                if(Pro_info != nil)
                    entity.Pro_info = [NSString stringWithUTF8String:Pro_info];
                
                char * Pro_goldWeight   = (char *)sqlite3_column_text(statement,8);
                if(Pro_goldWeight != nil)
                    entity.Pro_goldWeight = [NSString stringWithUTF8String:Pro_goldWeight];
                
                char * Pro_author   = (char *)sqlite3_column_text(statement,9);
                if(Pro_author != nil)
                    entity.Pro_author = [NSString stringWithUTF8String:Pro_author];
                
                char * Pro_Class   = (char *)sqlite3_column_text(statement,10);
                if(Pro_Class != nil)
                    entity.Pro_Class = [NSString stringWithUTF8String:Pro_Class];
                
                char * Pro_goldType   = (char *)sqlite3_column_text(statement,11);
                if(Pro_goldType != nil)
                    entity.Pro_goldType = [NSString stringWithUTF8String:Pro_goldType];
                
                char * Pro_f_pair   = (char *)sqlite3_column_text(statement,12);
                if(Pro_f_pair != nil)
                    entity.Pro_f_pair = [NSString stringWithUTF8String:Pro_f_pair];
                
                char * Pro_hotE   = (char *)sqlite3_column_text(statement,13);
                if(Pro_hotE != nil)
                    entity.Pro_hotE = [NSString stringWithUTF8String:Pro_hotE];
                
                char * Pro_Z_color   = (char *)sqlite3_column_text(statement,14);
                if(Pro_Z_color != nil)
                    entity.Pro_Z_color = [NSString stringWithUTF8String:Pro_Z_color];
                
                char * Pro_Z_weight   = (char *)sqlite3_column_text(statement,15);
                if(Pro_Z_weight != nil)
                    entity.Pro_Z_weight = [NSString stringWithUTF8String:Pro_Z_weight];
                
                char * Pro_Z_count   = (char *)sqlite3_column_text(statement,16);
                if(Pro_Z_count != nil)
                    entity.Pro_Z_count = [NSString stringWithUTF8String:Pro_Z_count];
                
                char * Pro_f_count   = (char *)sqlite3_column_text(statement,17);
                if(Pro_f_count != nil)
                    entity.Pro_f_count = [NSString stringWithUTF8String:Pro_f_count];
                
                char * Pro_f_weight   = (char *)sqlite3_column_text(statement,18);
                if(Pro_f_weight != nil)
                    entity.Pro_f_weight = [NSString stringWithUTF8String:Pro_f_weight];
                
                char * Pro_goldsize   = (char *)sqlite3_column_text(statement,19);
                if(Pro_goldsize != nil)
                    entity.Pro_goldsize = [NSString stringWithUTF8String:Pro_goldsize];
                
                char * Pro_MarketPrice   = (char *)sqlite3_column_text(statement,20);
                if(Pro_MarketPrice != nil)
                    entity.Pro_MarketPrice = [NSString stringWithUTF8String:Pro_MarketPrice];
                
                char * Pro_price   = (char *)sqlite3_column_text(statement,21);
                if(Pro_price != nil)
                    entity.Pro_price = [NSString stringWithUTF8String:Pro_price];
                
                char * Pro_Type   = (char *)sqlite3_column_text(statement,22);
                if(Pro_Type != nil)
                    entity.Pro_Type = [NSString stringWithUTF8String:Pro_Type];
                
                char * Pro_typeWenProId   = (char *)sqlite3_column_text(statement,23);
                if(Pro_typeWenProId != nil)
                    entity.Pro_typeWenProId = [NSString stringWithUTF8String:Pro_typeWenProId];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return entity;
}


//查询裸钻列表
-(NSMutableArray*)GetProductdiaList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 type5:(NSString *)type5 type6:(NSString *)type6 type7:(NSString *)type7 type8:(NSString *)type8 type9:(NSString *)type9 type10:(NSString *)type10 type11:(NSString *)type11 page:(int)page pageSize:(int)pageSize{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Dia_Lab,Dia_CertNo,Dia_Carat,Dia_Clar,Dia_Col,Dia_Cut,Dia_Pol,Dia_Sym,Dia_Shape,Dia_Dep,Dia_Tab,Dia_Meas,Dia_Flor,Dia_Price,Dia_Cost,Dia_ART,Dia_Corp,Dia_Theonly,Dia_Out,Dia_Tj,Dia_Addtime,Dia_XH,ColStep,ColCream,BackFlaw,TabFlaw,location,colordesc from productdia where 1=1 "];
        if (type1.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Shape in (%@) ",type1];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type2.length!=0) {
            NSString *classsql=nil;
            NSArray *weight=[type2 componentsSeparatedByString:@","];
            if ([weight count]==2) {
                classsql=[NSString stringWithFormat:@" and Dia_Carat between '%@' and '%@' ",[weight objectAtIndex:0],[weight objectAtIndex:1]];
            }else{
                classsql=[NSString stringWithFormat:@" and Dia_Carat>=%@ ",[weight objectAtIndex:0]];
            }
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type3.length!=0) {
            NSString *classsql=nil;
            NSArray *weight=[type3 componentsSeparatedByString:@","];
            if ([weight count]==2) {
                classsql=[NSString stringWithFormat:@" and Dia_Price between '%@' and '%@' ",[weight objectAtIndex:0],[weight objectAtIndex:1]];
            }else{
                classsql=[NSString stringWithFormat:@" and Dia_Price>=%@ ",[weight objectAtIndex:0]];
            }
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type4.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Col in (%@) ",type4];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type5.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Clar in (%@) ",type5];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type6.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Cut in (%@) ",type6];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type7.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Pol in (%@) ",type7];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type8.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Sym in (%@) ",type8];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type9.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Flor in (%@) ",type9];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type10.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_Lab in (%@) ",type10];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type11.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Dia_CertNo like '%%%@%%' ",type11];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@"group by Dia_CertNo limit %d offset %d",pageSize,offsetcount]];
        
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                productdia * entity = [[productdia alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Dia_Lab   = (char *)sqlite3_column_text(statement,1);
                if(Dia_Lab != nil)
                    entity.Dia_Lab = [NSString stringWithUTF8String:Dia_Lab];
                
                char * Dia_CertNo   = (char *)sqlite3_column_text(statement,2);
                if(Dia_CertNo != nil)
                    entity.Dia_CertNo = [NSString stringWithUTF8String:Dia_CertNo];
                
                char * Dia_Carat   = (char *)sqlite3_column_text(statement,3);
                if(Dia_Carat != nil)
                    entity.Dia_Carat = [NSString stringWithUTF8String:Dia_Carat];
                
                char * Dia_Clar   = (char *)sqlite3_column_text(statement,4);
                if(Dia_Clar != nil)
                    entity.Dia_Clar = [NSString stringWithUTF8String:Dia_Clar];
                
                char * Dia_Col   = (char *)sqlite3_column_text(statement,5);
                if(Dia_Col != nil)
                    entity.Dia_Col = [NSString stringWithUTF8String:Dia_Col];
                
                char * Dia_Cut   = (char *)sqlite3_column_text(statement,6);
                if(Dia_Cut != nil)
                    entity.Dia_Cut = [NSString stringWithUTF8String:Dia_Cut];
                
                char * Dia_Pol   = (char *)sqlite3_column_text(statement,7);
                if(Dia_Pol != nil)
                    entity.Dia_Pol = [NSString stringWithUTF8String:Dia_Pol];
                
                char * Dia_Sym   = (char *)sqlite3_column_text(statement,8);
                if(Dia_Sym != nil)
                    entity.Dia_Sym = [NSString stringWithUTF8String:Dia_Sym];
                
                char * Dia_Shape   = (char *)sqlite3_column_text(statement,9);
                if(Dia_Shape != nil)
                    entity.Dia_Shape = [NSString stringWithUTF8String:Dia_Shape];
                
                char * Dia_Dep   = (char *)sqlite3_column_text(statement,10);
                if(Dia_Dep != nil)
                    entity.Dia_Dep = [NSString stringWithUTF8String:Dia_Dep];
                
                char * Dia_Tab   = (char *)sqlite3_column_text(statement,11);
                if(Dia_Tab != nil)
                    entity.Dia_Tab = [NSString stringWithUTF8String:Dia_Tab];
                
                char * Dia_Meas   = (char *)sqlite3_column_text(statement,12);
                if(Dia_Meas != nil)
                    entity.Dia_Meas = [NSString stringWithUTF8String:Dia_Meas];
                
                char * Dia_Flor   = (char *)sqlite3_column_text(statement,13);
                if(Dia_Flor != nil)
                    entity.Dia_Flor = [NSString stringWithUTF8String:Dia_Flor];
                
                char * Dia_Price   = (char *)sqlite3_column_text(statement,14);
                if(Dia_Price != nil)
                    entity.Dia_Price = [NSString stringWithUTF8String:Dia_Price];
                
                char * Dia_Cost   = (char *)sqlite3_column_text(statement,15);
                if(Dia_Cost != nil)
                    entity.Dia_Cost = [NSString stringWithUTF8String:Dia_Cost];
                
                char * Dia_ART   = (char *)sqlite3_column_text(statement,16);
                if(Dia_ART != nil)
                    entity.Dia_ART = [NSString stringWithUTF8String:Dia_ART];
                
                char * Dia_Corp   = (char *)sqlite3_column_text(statement,17);
                if(Dia_Corp != nil)
                    entity.Dia_Corp = [NSString stringWithUTF8String:Dia_Corp];
                
                char * Dia_Theonly   = (char *)sqlite3_column_text(statement,18);
                if(Dia_Theonly != nil)
                    entity.Dia_Theonly = [NSString stringWithUTF8String:Dia_Theonly];
                
                char * Dia_Out   = (char *)sqlite3_column_text(statement,19);
                if(Dia_Out != nil)
                    entity.Dia_Out = [NSString stringWithUTF8String:Dia_Out];
                
                char * Dia_Tj   = (char *)sqlite3_column_text(statement,20);
                if(Dia_Tj != nil)
                    entity.Dia_Tj = [NSString stringWithUTF8String:Dia_Tj];
                
                char * Dia_Addtime   = (char *)sqlite3_column_text(statement,21);
                if(Dia_Addtime != nil)
                    entity.Dia_Addtime = [NSString stringWithUTF8String:Dia_Addtime];
                
                char * Dia_XH   = (char *)sqlite3_column_text(statement,22);
                if(Dia_XH != nil)
                    entity.Dia_XH = [NSString stringWithUTF8String:Dia_XH];
                
                char * ColStep   = (char *)sqlite3_column_text(statement,23);
                if(ColStep != nil)
                    entity.ColStep = [NSString stringWithUTF8String:ColStep];
                
                char * ColCream   = (char *)sqlite3_column_text(statement,24);
                if(ColCream != nil)
                    entity.ColCream = [NSString stringWithUTF8String:ColCream];
                
                char * BackFlaw   = (char *)sqlite3_column_text(statement,25);
                if(BackFlaw != nil)
                    entity.BackFlaw = [NSString stringWithUTF8String:BackFlaw];
                
                char * TabFlaw   = (char *)sqlite3_column_text(statement,26);
                if(TabFlaw != nil)
                    entity.TabFlaw = [NSString stringWithUTF8String:TabFlaw];
                
                char * location   = (char *)sqlite3_column_text(statement,27);
                if(location != nil)
                    entity.location = [NSString stringWithUTF8String:location];
                
                char * colordesc   = (char *)sqlite3_column_text(statement,28);
                if(colordesc != nil)
                    entity.colordesc = [NSString stringWithUTF8String:colordesc];
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询裸钻明细
-(productdia*)GetProductdiaDetail:(NSString *)pid{

    productdia * entity = [[productdia alloc] init];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Dia_Lab,Dia_CertNo,Dia_Carat,Dia_Clar,Dia_Col,Dia_Cut,Dia_Pol,Dia_Sym,Dia_Shape,Dia_Dep,Dia_Tab,Dia_Meas,Dia_Flor,Dia_Price,Dia_Cost,Dia_ART,Dia_Corp,Dia_Theonly,Dia_Out,Dia_Tj,Dia_Addtime,Dia_XH,ColStep,ColCream,BackFlaw,TabFlaw,location,colordesc from productdia where Id=%@ ",pid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {

                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Dia_Lab   = (char *)sqlite3_column_text(statement,1);
                if(Dia_Lab != nil)
                    entity.Dia_Lab = [NSString stringWithUTF8String:Dia_Lab];
                
                char * Dia_CertNo   = (char *)sqlite3_column_text(statement,2);
                if(Dia_CertNo != nil)
                    entity.Dia_CertNo = [NSString stringWithUTF8String:Dia_CertNo];
                
                char * Dia_Carat   = (char *)sqlite3_column_text(statement,3);
                if(Dia_Carat != nil)
                    entity.Dia_Carat = [NSString stringWithUTF8String:Dia_Carat];
                
                char * Dia_Clar   = (char *)sqlite3_column_text(statement,4);
                if(Dia_Clar != nil)
                    entity.Dia_Clar = [NSString stringWithUTF8String:Dia_Clar];
                
                char * Dia_Col   = (char *)sqlite3_column_text(statement,5);
                if(Dia_Col != nil)
                    entity.Dia_Col = [NSString stringWithUTF8String:Dia_Col];
                
                char * Dia_Cut   = (char *)sqlite3_column_text(statement,6);
                if(Dia_Cut != nil)
                    entity.Dia_Cut = [NSString stringWithUTF8String:Dia_Cut];
                
                char * Dia_Pol   = (char *)sqlite3_column_text(statement,7);
                if(Dia_Pol != nil)
                    entity.Dia_Pol = [NSString stringWithUTF8String:Dia_Pol];
                
                char * Dia_Sym   = (char *)sqlite3_column_text(statement,8);
                if(Dia_Sym != nil)
                    entity.Dia_Sym = [NSString stringWithUTF8String:Dia_Sym];
                
                char * Dia_Shape   = (char *)sqlite3_column_text(statement,9);
                if(Dia_Shape != nil)
                    entity.Dia_Shape = [NSString stringWithUTF8String:Dia_Shape];
                
                char * Dia_Dep   = (char *)sqlite3_column_text(statement,10);
                if(Dia_Dep != nil)
                    entity.Dia_Dep = [NSString stringWithUTF8String:Dia_Dep];
                
                char * Dia_Tab   = (char *)sqlite3_column_text(statement,11);
                if(Dia_Tab != nil)
                    entity.Dia_Tab = [NSString stringWithUTF8String:Dia_Tab];
                
                char * Dia_Meas   = (char *)sqlite3_column_text(statement,12);
                if(Dia_Meas != nil)
                    entity.Dia_Meas = [NSString stringWithUTF8String:Dia_Meas];
                
                char * Dia_Flor   = (char *)sqlite3_column_text(statement,13);
                if(Dia_Flor != nil)
                    entity.Dia_Flor = [NSString stringWithUTF8String:Dia_Flor];
                
                char * Dia_Price   = (char *)sqlite3_column_text(statement,14);
                if(Dia_Price != nil)
                    entity.Dia_Price = [NSString stringWithUTF8String:Dia_Price];
                
                char * Dia_Cost   = (char *)sqlite3_column_text(statement,15);
                if(Dia_Cost != nil)
                    entity.Dia_Cost = [NSString stringWithUTF8String:Dia_Cost];
                
                char * Dia_ART   = (char *)sqlite3_column_text(statement,16);
                if(Dia_ART != nil)
                    entity.Dia_ART = [NSString stringWithUTF8String:Dia_ART];
                
                char * Dia_Corp   = (char *)sqlite3_column_text(statement,17);
                if(Dia_Corp != nil)
                    entity.Dia_Corp = [NSString stringWithUTF8String:Dia_Corp];
                
                char * Dia_Theonly   = (char *)sqlite3_column_text(statement,18);
                if(Dia_Theonly != nil)
                    entity.Dia_Theonly = [NSString stringWithUTF8String:Dia_Theonly];
                
                char * Dia_Out   = (char *)sqlite3_column_text(statement,19);
                if(Dia_Out != nil)
                    entity.Dia_Out = [NSString stringWithUTF8String:Dia_Out];
                
                char * Dia_Tj   = (char *)sqlite3_column_text(statement,20);
                if(Dia_Tj != nil)
                    entity.Dia_Tj = [NSString stringWithUTF8String:Dia_Tj];
                
                char * Dia_Addtime   = (char *)sqlite3_column_text(statement,21);
                if(Dia_Addtime != nil)
                    entity.Dia_Addtime = [NSString stringWithUTF8String:Dia_Addtime];
                
                char * Dia_XH   = (char *)sqlite3_column_text(statement,22);
                if(Dia_XH != nil)
                    entity.Dia_XH = [NSString stringWithUTF8String:Dia_XH];
                
                char * ColStep   = (char *)sqlite3_column_text(statement,23);
                if(ColStep != nil)
                    entity.ColStep = [NSString stringWithUTF8String:ColStep];
                
                char * ColCream   = (char *)sqlite3_column_text(statement,24);
                if(ColCream != nil)
                    entity.ColCream = [NSString stringWithUTF8String:ColCream];
                
                char * BackFlaw   = (char *)sqlite3_column_text(statement,25);
                if(BackFlaw != nil)
                    entity.BackFlaw = [NSString stringWithUTF8String:BackFlaw];
                
                char * TabFlaw   = (char *)sqlite3_column_text(statement,26);
                if(TabFlaw != nil)
                    entity.TabFlaw = [NSString stringWithUTF8String:TabFlaw];
                
                char * location   = (char *)sqlite3_column_text(statement,27);
                if(location != nil)
                    entity.location = [NSString stringWithUTF8String:location];
                
                char * colordesc   = (char *)sqlite3_column_text(statement,28);
                if(colordesc != nil)
                    entity.colordesc = [NSString stringWithUTF8String:colordesc];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return entity;
}

//查询用户的购物车信息
-(NSMutableArray*)GetBuyproductList:(NSString *)customerid{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT buy.Id,buy.pcolor,buy.pcount,buy.pdetail,buy.psize,buy.pprice,buy.producttype,buy.pvvs,buy.pweight,buy.pgoldtype,pro.Pro_name,pro.Pro_State,pro.Pro_smallpic,pro.Pro_bigpic,pro.Pro_info,pro.Pro_goldWeight,pro.Pro_goldsize,pro.Pro_goldset,pro.Pro_FingerSize,pro.Pro_gongfei,pro.Pro_MarketPrice,pro.Pro_price,pro.Pro_OKdays,pro.Pro_hotE,buy.pname from buyproduct as buy,product as pro where pro.Id=buy.productid and buy.customerid=%@ and buy.producttype in (1,2,10) union all SELECT buy.Id,buy.pcolor,buy.pcount,buy.pdetail,buy.psize,buy.pprice,buy.producttype,buy.pvvs,buy.pweight,buy.pgoldtype,pro.Dia_Lab,pro.Dia_CertNo,pro.Dia_Carat,pro.Dia_Clar,pro.Dia_Col,pro.Dia_Cut,pro.Dia_Pol,pro.Dia_Sym,pro.Dia_Shape,pro.Dia_Dep,pro.Dia_Tab,pro.Dia_Meas,pro.Dia_Flor,pro.Dia_Price,buy.pname from buyproduct as buy,productdia as pro where pro.Id=buy.productid and buy.customerid=%@ and buy.producttype=3 union all SELECT buy.Id,buy.pcolor,buy.pcount,buy.pdetail,buy.psize,buy.pprice,buy.producttype,buy.pvvs,buy.pweight,buy.pgoldtype,buy.photos,buy.photom,buy.photob,buy.Dia_Z_weight,buy.Dia_Z_count,buy.Dia_F_weight,buy.Dia_F_count,0 as Dia_Sym,0 as Dia_Shape,0 as Dia_Dep,0 as Dia_Tab,0 as Dia_Meas,0 as Dia_Flor,0 as Dia_Price,buy.pname from buyproduct as buy where buy.customerid=%@ and buy.producttype=9 ",customerid,customerid,customerid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                buyproduct * entity = [[buyproduct alloc] init];
                entity.proentiy=[[productEntity alloc] init];
                entity.diaentiy=[[productdia alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * pcolor   = (char *)sqlite3_column_text(statement,1);
                if(pcolor != nil)
                    entity.pcolor = [NSString stringWithUTF8String:pcolor];
                
                char * pcount   = (char *)sqlite3_column_text(statement,2);
                if(pcount != nil)
                    entity.pcount = [NSString stringWithUTF8String:pcount];
                
                char * pdetail   = (char *)sqlite3_column_text(statement,3);
                if(pdetail != nil)
                    entity.pdetail = [NSString stringWithUTF8String:pdetail];
                
                char * psize   = (char *)sqlite3_column_text(statement,4);
                if(psize != nil)
                    entity.psize = [NSString stringWithUTF8String:psize];
                
                char * pprice   = (char *)sqlite3_column_text(statement,5);
                if(pprice != nil)
                    entity.pprice = [NSString stringWithUTF8String:pprice];
                
                char * producttype   = (char *)sqlite3_column_text(statement,6);
                if(producttype != nil)
                    entity.producttype = [NSString stringWithUTF8String:producttype];
                
                char * pvvs   = (char *)sqlite3_column_text(statement,7);
                if(pvvs != nil)
                    entity.pvvs = [NSString stringWithUTF8String:pvvs];
                
                char * pweight   = (char *)sqlite3_column_text(statement,8);
                if(pweight != nil)
                    entity.pweight = [NSString stringWithUTF8String:pweight];
                
                char * pgoldtype   = (char *)sqlite3_column_text(statement,9);
                if(pgoldtype != nil)
                    entity.pgoldtype = [NSString stringWithUTF8String:pgoldtype];
                
                //（0代表是商品，1是钻，2高级定制）类型 1戒托 2商品 3裸钻 9高级定制 10是本地商品
                char * Pro_name   = (char *)sqlite3_column_text(statement,10);
                if(Pro_name != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"])entity.proentiy.Pro_name = [NSString stringWithUTF8String:Pro_name];
                    else if([entity.producttype isEqualToString:@"3"]) entity.diaentiy.Dia_Lab = [NSString stringWithUTF8String:Pro_name];
                    else entity.photos= [NSString stringWithUTF8String:Pro_name];
                }
                
                char * Pro_State   = (char *)sqlite3_column_text(statement,11);
                if(Pro_State != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"])entity.proentiy.Pro_State = [NSString stringWithUTF8String:Pro_State];
                    else if([entity.producttype isEqualToString:@"3"]) entity.diaentiy.Dia_CertNo = [NSString stringWithUTF8String:Pro_State];
                    else entity.photom= [NSString stringWithUTF8String:Pro_State];
                }
                
                char * Pro_smallpic   = (char *)sqlite3_column_text(statement,12);
                if(Pro_smallpic != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"])entity.proentiy.Pro_smallpic = [NSString stringWithUTF8String:Pro_smallpic];
                    else if([entity.producttype isEqualToString:@"3"]) entity.diaentiy.Dia_Carat = [NSString stringWithUTF8String:Pro_smallpic];
                    else entity.photob= [NSString stringWithUTF8String:Pro_smallpic];
                }
                
                char * Pro_bigpic   = (char *)sqlite3_column_text(statement,13);
                if(Pro_bigpic != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_bigpic = [NSString stringWithUTF8String:Pro_bigpic];
                    }else if([entity.producttype isEqualToString:@"3"]) {entity.diaentiy.Dia_Clar = [NSString stringWithUTF8String:Pro_bigpic];}
                    else entity.Dia_Z_weight= [NSString stringWithUTF8String:Pro_bigpic];
                }

                char * Pro_info   = (char *)sqlite3_column_text(statement,14);
                if(Pro_info != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_info = [NSString stringWithUTF8String:Pro_info];
                    }else if([entity.producttype isEqualToString:@"3"]) {entity.diaentiy.Dia_Col = [NSString stringWithUTF8String:Pro_info];}
                    else entity.Dia_Z_count= [NSString stringWithUTF8String:Pro_info];
                }
                
                char * Pro_goldWeight   = (char *)sqlite3_column_text(statement,15);
                if(Pro_goldWeight != nil){
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_goldWeight = [NSString stringWithUTF8String:Pro_goldWeight];
                    }else if([entity.producttype isEqualToString:@"3"]){ entity.diaentiy.Dia_Cut = [NSString stringWithUTF8String:Pro_goldWeight];}
                    else entity.Dia_F_weight= [NSString stringWithUTF8String:Pro_goldWeight];
                }
                
                char * Pro_goldsize   = (char *)sqlite3_column_text(statement,16);
                if(Pro_goldsize != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_goldsize = [NSString stringWithUTF8String:Pro_goldsize];
                    }else if([entity.producttype isEqualToString:@"3"]){ entity.diaentiy.Dia_Pol = [NSString stringWithUTF8String:Pro_goldsize];}
                    else entity.Dia_F_count= [NSString stringWithUTF8String:Pro_goldsize];
                }
                
                char * Pro_goldset   = (char *)sqlite3_column_text(statement,17);
                if(Pro_goldset != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_goldset = [NSString stringWithUTF8String:Pro_goldset];
                    }else{ entity.diaentiy.Dia_Sym = [NSString stringWithUTF8String:Pro_goldset];}
                }
                
                char * Pro_FingerSize   = (char *)sqlite3_column_text(statement,18);
                if(Pro_FingerSize != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_FingerSize = [NSString stringWithUTF8String:Pro_FingerSize];
                    }else{ entity.diaentiy.Dia_Shape = [NSString stringWithUTF8String:Pro_FingerSize];}
                }
                
                char * Pro_gongfei   = (char *)sqlite3_column_text(statement,19);
                if(Pro_gongfei != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_gongfei = [NSString stringWithUTF8String:Pro_gongfei];
                    }else{ entity.diaentiy.Dia_Dep = [NSString stringWithUTF8String:Pro_gongfei];}
                }
                
                char * Pro_MarketPrice   = (char *)sqlite3_column_text(statement,20);
                if(Pro_MarketPrice != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_MarketPrice = [NSString stringWithUTF8String:Pro_MarketPrice];
                    }else{ entity.diaentiy.Dia_Tab = [NSString stringWithUTF8String:Pro_MarketPrice];}
                }
                
                char * Pro_price   = (char *)sqlite3_column_text(statement,21);
                if(Pro_price != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_price = [NSString stringWithUTF8String:Pro_price];
                    }else{ entity.diaentiy.Dia_Meas = [NSString stringWithUTF8String:Pro_price];}
                }
                
                char * Pro_OKdays   = (char *)sqlite3_column_text(statement,22);
                if(Pro_OKdays != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_OKdays = [NSString stringWithUTF8String:Pro_OKdays];
                    }else{ entity.diaentiy.Dia_Flor = [NSString stringWithUTF8String:Pro_OKdays];}
                }
                
                char * Pro_hotE   = (char *)sqlite3_column_text(statement,23);
                if(Pro_hotE != nil)
                {
                    if([entity.producttype isEqualToString:@"1"] || [entity.producttype isEqualToString:@"2"] || [entity.producttype isEqualToString:@"10"]){entity.proentiy.Pro_hotE = [NSString stringWithUTF8String:Pro_hotE];
                    }else{ entity.diaentiy.Dia_Price = [NSString stringWithUTF8String:Pro_hotE];}
                }
                
                char * pname   = (char *)sqlite3_column_text(statement,24);
                if(pname != nil)
                    entity.pname = [NSString stringWithUTF8String:pname];

                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//根据用户的id查询购物车的数量
-(NSString*)getBuyproductcount:(NSString*)uid{
    
    NSString * gcounts=@"0";
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT count(productid) as counts from buyproduct where customerid=%@ and producttype in (1,2,3,9,10) ",uid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char * counts   = (char *)sqlite3_column_text(statement,0);
                if(counts != nil)
                    gcounts = [NSString stringWithUTF8String:counts];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return gcounts;
}


//修改购物车
-(NSString *)updateBuyproduct:(buyproduct *)entity{
    
    @try {
        
        NSString * sql=[NSString stringWithFormat:@" update buyproduct set pcount='%@'  where Id=%@",entity.pcount,entity.Id];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self execSqlandClose:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return @"1";
    
}

//查询商品的3d图片
-(NSMutableArray*)getProductRAR:(NSString *)pid{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,zipUrl from productphotos where Id=%@ ",pid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                productphotos * entity = [[productphotos alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * zipUrl   = (char *)sqlite3_column_text(statement,1);
                if(zipUrl != nil)
                    entity.zipUrl = [NSString stringWithUTF8String:zipUrl];
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询所有的商品的3d图片
-(NSMutableArray*)getAllProductRAR{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,zipUrl from productphotos "];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                productphotos * entity = [[productphotos alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * zipUrl   = (char *)sqlite3_column_text(statement,1);
                if(zipUrl != nil)
                    entity.zipUrl = [NSString stringWithUTF8String:zipUrl];
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询当前用户的基本信息
-(customer*)getCustomer:(NSString *)uid{
    
    customer * entity = [[customer alloc] init];
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT uId,userType,userName,userPass,userDueDate,userTrueName,sfUrl,lxrName,Sex,bmName,Email,Phone,Lxphone,Sf,Cs,Address from customer where uId=%@ ",uid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {

                char * uId   = (char *)sqlite3_column_text(statement,0);
                if(uId != nil)
                    entity.uId = [NSString stringWithUTF8String:uId];
                
                char * userType   = (char *)sqlite3_column_text(statement,1);
                if(userType != nil)
                    entity.userType = [NSString stringWithUTF8String:userType];
                
                char * userName   = (char *)sqlite3_column_text(statement,2);
                if(userName != nil)
                    entity.userName = [NSString stringWithUTF8String:userName];
                
                char * userPass   = (char *)sqlite3_column_text(statement,3);
                if(userPass != nil)
                    entity.userPass = [NSString stringWithUTF8String:userPass];
                
                char * userDueDate   = (char *)sqlite3_column_text(statement,4);
                if(userDueDate != nil)
                    entity.userDueDate = [NSString stringWithUTF8String:userDueDate];
                
                char * userTrueName   = (char *)sqlite3_column_text(statement,5);
                if(userTrueName != nil)
                    entity.userTrueName = [NSString stringWithUTF8String:userTrueName];
                
                char * sfUrl   = (char *)sqlite3_column_text(statement,6);
                if(sfUrl != nil)
                    entity.sfUrl = [NSString stringWithUTF8String:sfUrl];
                
                char * lxrName   = (char *)sqlite3_column_text(statement,7);
                if(lxrName != nil)
                    entity.lxrName = [NSString stringWithUTF8String:lxrName];
                
                char * Sex   = (char *)sqlite3_column_text(statement,8);
                if(Sex != nil)
                    entity.Sex = [NSString stringWithUTF8String:Sex];
                
                char * bmName   = (char *)sqlite3_column_text(statement,9);
                if(bmName != nil)
                    entity.bmName = [NSString stringWithUTF8String:bmName];
                
                char * Email   = (char *)sqlite3_column_text(statement,10);
                if(Email != nil)
                    entity.Email = [NSString stringWithUTF8String:Email];
                
                char * Phone   = (char *)sqlite3_column_text(statement,11);
                if(Phone != nil)
                    entity.Phone = [NSString stringWithUTF8String:Phone];
                
                char * Lxphone   = (char *)sqlite3_column_text(statement,12);
                if(Lxphone != nil)
                    entity.Lxphone = [NSString stringWithUTF8String:Lxphone];
                
                char * Sf   = (char *)sqlite3_column_text(statement,13);
                if(Sf != nil)
                    entity.Sf = [NSString stringWithUTF8String:Sf];
                
                char * Cs   = (char *)sqlite3_column_text(statement,14);
                if(Cs != nil)
                    entity.Cs = [NSString stringWithUTF8String:Cs];
                
                char * Address   = (char *)sqlite3_column_text(statement,15);
                if(Address != nil)
                    entity.Address = [NSString stringWithUTF8String:Address];
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return entity;
}

//根据编号查询上次更新数据的时间
-(NSString*)getUpdateTime:(NSString *)code{
    
    NSString *updatetimes=@"0";
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT updatetimevalue from updatetime where updateCode='%@' ",code];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return @"0";
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char * updatetime   = (char *)sqlite3_column_text(statement,0);
                if(updatetime != nil)
                    updatetimes=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:updatetime]];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return updatetimes;
}

//新加商品
-(productEntity*)saveProduct:(productEntity *)entity{

    @try {
        NSString *tablekey=@"Id,Pro_model,Pro_name,Pro_State,Pro_Class,Pro_Type,Pro_smallpic,Pro_bigpic,Pro_typeWenProId,Pro_info,Pro_lock,Pro_IsDel,Pro_author,Pro_Order,Pro_addtime,Pro_goldType,Pro_goldWeight,Pro_goldsize,Pro_goldset,Pro_FingerSize,Pro_gongfei,Pro_MarketPrice,Pro_price,Pro_OKdays,Pro_Salenums,Pro_hotA,Pro_hotB,Pro_hotC,Pro_hotD,Pro_hotE,Pro_Z_count,Pro_Z_GIA,Pro_Z_number,Pro_Z_weight,Pro_Z_color,Pro_Z_cut,Pro_Z_clarity,Pro_Z_polish,Pro_Z_pair,Pro_Z_price,Pro_f_count,Pro_F_GIA,Pro_f_number,Pro_f_weight,Pro_f_color,Pro_f_cut,Pro_f_clarity,Pro_f_polish,Pro_f_pair,Pro_f_price,Pro_D_Hand,Pro_D_Width,Pro_D_Dia,Pro_D_Bangle,Pro_D_Ear,Pro_D_Height,Pro_SmallClass,IsCaijin,Di_DiaShape,Pro_GroupSerial,Pro_FactoryNumber,Pro_domondB,Pro_domondE,Pro_ChiCun,Pro_goldWeightB,Pro_gongfeiB,Pro_zhuanti,location,zWeight,AuWeight,ptWeight,producttype";
        
        NSString * values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",entity.Id,entity.Pro_model,entity.Pro_name,entity.Pro_State,entity.Pro_Class,entity.Pro_Type,entity.Pro_smallpic,entity.Pro_bigpic,entity.Pro_typeWenProId,entity.Pro_info,entity.Pro_lock,entity.Pro_IsDel,entity.Pro_author,entity.Pro_Order,entity.Pro_addtime,entity.Pro_goldType,entity.Pro_goldWeight,entity.Pro_goldsize,entity.Pro_goldset,entity.Pro_FingerSize,entity.Pro_gongfei,entity.Pro_MarketPrice,entity.Pro_price,entity.Pro_OKdays,entity.Pro_Salenums,entity.Pro_hotA,entity.Pro_hotB,entity.Pro_hotC,entity.Pro_hotD,entity.Pro_hotE,entity.Pro_Z_count,entity.Pro_Z_GIA,entity.Pro_Z_number,entity.Pro_Z_weight,entity.Pro_Z_color,entity.Pro_Z_cut,entity.Pro_Z_clarity,entity.Pro_Z_polish,entity.Pro_Z_pair,entity.Pro_Z_price,entity.Pro_f_count,entity.Pro_F_GIA,entity.Pro_f_number,entity.Pro_f_weight,entity.Pro_f_color,entity.Pro_f_cut,entity.Pro_f_clarity,entity.Pro_f_polish,entity.Pro_f_pair,entity.Pro_f_price,entity.Pro_D_Hand,entity.Pro_D_Width,entity.Pro_D_Dia,entity.Pro_D_Bangle,entity.Pro_D_Ear,entity.Pro_D_Height,entity.Pro_SmallClass,entity.IsCaijin,entity.Di_DiaShape,entity.Pro_GroupSerial,entity.Pro_FactoryNumber,entity.Pro_domondB,entity.Pro_domondE,entity.Pro_ChiCun,entity.Pro_goldWeightB,entity.Pro_gongfeiB,entity.Pro_zhuanti,entity.location,entity.zWeight,entity.AuWeight,entity.ptWeight,entity.producttype];
        
        NSString * sql=[NSString stringWithFormat:@"insert into product(%@)values(%@)",tablekey,values];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self execSqlandClose:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return entity;

}

//修改商品
-(productEntity*)updateProduct:(productEntity *)entity{
    
    @try {
//        NSString *tablekey=@"Id,Pro_model,Pro_name,Pro_State,Pro_Class,Pro_Type,Pro_smallpic,Pro_bigpic,Pro_typeWenProId,Pro_info,Pro_lock,Pro_IsDel,Pro_author,Pro_Order,Pro_addtime,Pro_goldType,Pro_goldWeight,Pro_goldsize,Pro_goldset,Pro_FingerSize,Pro_gongfei,Pro_MarketPrice,Pro_price,Pro_OKdays,Pro_Salenums,Pro_hotA,Pro_hotB,Pro_hotC,Pro_hotD,Pro_hotE,Pro_Z_count,Pro_Z_GIA,Pro_Z_number,Pro_Z_weight,Pro_Z_color,Pro_Z_cut,Pro_Z_clarity,Pro_Z_polish,Pro_Z_pair,Pro_Z_price,Pro_f_count,Pro_F_GIA,Pro_f_number,Pro_f_weight,Pro_f_color,Pro_f_cut,Pro_f_clarity,Pro_f_polish,Pro_f_pair,Pro_f_price,Pro_D_Hand,Pro_D_Width,Pro_D_Dia,Pro_D_Bangle,Pro_D_Ear,Pro_D_Height,Pro_SmallClass,IsCaijin,Di_DiaShape,Pro_GroupSerial,Pro_FactoryNumber,Pro_domondB,Pro_domondE,Pro_ChiCun,Pro_goldWeightB,Pro_gongfeiB,Pro_zhuanti,location,zWeight,AuWeight,ptWeight,producttype";
        
        NSString * values =[NSString stringWithFormat:@"Pro_model='%@',Pro_name='%@',Pro_State='%@',Pro_Class='%@',Pro_Type='%@',Pro_smallpic='%@',Pro_bigpic='%@',Pro_typeWenProId='%@',Pro_info='%@',Pro_lock='%@',Pro_IsDel='%@',Pro_author='%@',Pro_Order='%@',Pro_addtime='%@',Pro_goldType='%@',Pro_goldWeight='%@',Pro_goldsize='%@',Pro_goldset='%@',Pro_FingerSize='%@',Pro_gongfei='%@',Pro_MarketPrice='%@',Pro_price='%@',Pro_OKdays='%@',Pro_Salenums='%@',Pro_hotA='%@',Pro_hotB='%@',Pro_hotC='%@',Pro_hotD='%@',Pro_hotE='%@',Pro_Z_count='%@',Pro_Z_GIA='%@',Pro_Z_number='%@',Pro_Z_weight='%@',Pro_Z_color='%@',Pro_Z_cut='%@',Pro_Z_clarity='%@',Pro_Z_polish='%@',Pro_Z_pair='%@',Pro_Z_price='%@',Pro_f_count='%@',Pro_F_GIA='%@',Pro_f_number='%@',Pro_f_weight='%@',Pro_f_color='%@',Pro_f_cut='%@',Pro_f_clarity='%@',Pro_f_polish='%@',Pro_f_pair='%@',Pro_f_price='%@',Pro_D_Hand='%@',Pro_D_Width='%@',Pro_D_Dia='%@',Pro_D_Bangle='%@',Pro_D_Ear='%@',Pro_D_Height='%@',Pro_SmallClass='%@',IsCaijin='%@',Di_DiaShape='%@',Pro_GroupSerial='%@',Pro_FactoryNumber='%@',Pro_domondB='%@',Pro_domondE='%@',Pro_ChiCun='%@',Pro_goldWeightB='%@',Pro_gongfeiB='%@',Pro_zhuanti='%@',location='%@',zWeight='%@',AuWeight='%@',ptWeight='%@',producttype='%@'",entity.Pro_model,entity.Pro_name,entity.Pro_State,entity.Pro_Class,entity.Pro_Type,entity.Pro_smallpic,entity.Pro_bigpic,entity.Pro_typeWenProId,entity.Pro_info,entity.Pro_lock,entity.Pro_IsDel,entity.Pro_author,entity.Pro_Order,entity.Pro_addtime,entity.Pro_goldType,entity.Pro_goldWeight,entity.Pro_goldsize,entity.Pro_goldset,entity.Pro_FingerSize,entity.Pro_gongfei,entity.Pro_MarketPrice,entity.Pro_price,entity.Pro_OKdays,entity.Pro_Salenums,entity.Pro_hotA,entity.Pro_hotB,entity.Pro_hotC,entity.Pro_hotD,entity.Pro_hotE,entity.Pro_Z_count,entity.Pro_Z_GIA,entity.Pro_Z_number,entity.Pro_Z_weight,entity.Pro_Z_color,entity.Pro_Z_cut,entity.Pro_Z_clarity,entity.Pro_Z_polish,entity.Pro_Z_pair,entity.Pro_Z_price,entity.Pro_f_count,entity.Pro_F_GIA,entity.Pro_f_number,entity.Pro_f_weight,entity.Pro_f_color,entity.Pro_f_cut,entity.Pro_f_clarity,entity.Pro_f_polish,entity.Pro_f_pair,entity.Pro_f_price,entity.Pro_D_Hand,entity.Pro_D_Width,entity.Pro_D_Dia,entity.Pro_D_Bangle,entity.Pro_D_Ear,entity.Pro_D_Height,entity.Pro_SmallClass,entity.IsCaijin,entity.Di_DiaShape,entity.Pro_GroupSerial,entity.Pro_FactoryNumber,entity.Pro_domondB,entity.Pro_domondE,entity.Pro_ChiCun,entity.Pro_goldWeightB,entity.Pro_gongfeiB,entity.Pro_zhuanti,entity.location,entity.zWeight,entity.AuWeight,entity.ptWeight,entity.producttype];
        
        NSString * sql=[NSString stringWithFormat:@" update product set %@  where Id=%@",values,entity.Id];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self execSqlandClose:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return entity;
    
}

//删除商品信息
-(NSString*)deleteProduct:(NSString *)pid{
    
    @try {
        //只能删除自己新加的商品
        NSString * sql=[NSString stringWithFormat:@"delete from product where Id=%@ and producttype=1",pid];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self HandleSql:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return pid;
}

//新加到购物车信息
-(buyproduct*)addToBuyproduct:(buyproduct *)entity{
    
    @try {
        
        //NSString * timesd=[self getTimeNowOT];
        
        NSString *tablekey=@"productid,pcolor,pcount,pdetail,psize,pprice,customerid,producttype,pvvs,pweight,pgoldtype,pname,photos,photom,photob,Dia_Z_weight,Dia_Z_count,Dia_F_weight,Dia_F_count,pro_model";
        
        NSString * values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",entity.productid,entity.pcolor,entity.pcount,entity.pdetail,entity.psize,entity.pprice,entity.customerid,entity.producttype,entity.pvvs,entity.pweight,entity.pgoldtype,entity.pname,entity.photos,entity.photom,entity.photob,entity.Dia_Z_weight,entity.Dia_Z_count,entity.Dia_F_weight,entity.Dia_F_count,entity.pro_model];
        
        NSString * sql=[NSString stringWithFormat:@"insert into [buyproduct](%@)values(%@);",tablekey,values];
        
        NSLog(@"--------------:%@",sql);
        //HandleSql
        if (![self HandleSql:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }

    return entity;
}

- (NSString *)getTimeNowOT
{
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];
    return timeSp;
}

//删除购物车信息
-(NSString*)deleteBuyproduct:(NSString *)pid{
    
    @try {
        
        NSString * sql=[NSString stringWithFormat:@"DELETE from [buyproduct] where Id=%@",pid];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self HandleSql:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        //[self closeDB];
    }
    
    return pid;
}

//根据产品删除购物车信息
-(NSString*)deleteBuyproductBypid:(NSString *)pid{
    
    @try {
        
        NSString * sql=[NSString stringWithFormat:@"DELETE from [buyproduct] where productid=%@",pid];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self HandleSql:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        //[self closeDB];
    }
    
    return pid;
}

//更新当前用户的基本信息(不调用接口更新服务器的信息)
-(customer*)updateCustomerNoApi:(customer *)entity{
    
    @try {
            //先删除之前的用户信息
            //[self ClearTableDatas:[NSString stringWithFormat:@" [customer] where uId='%@'",entity.uId]];
        
//        NSString * sql0=[NSString stringWithFormat:@"delete from customer where uId=%@ ",entity.uId];
//        
//        NSLog(@"--------------:%@",sql0);
//        [self HandleSql:sql0];
        
            NSString *tablekey=@"uId,userType,userName,userPass,userDueDate,userTrueName,sfUrl,lxrName,Sex,bmName,Email,Phone,Lxphone,Sf,Cs,Address";
            
            NSString * values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",entity.uId,entity.userType,entity.userName,entity.userPass,entity.userDueDate,entity.userTrueName,entity.sfUrl,entity.lxrName,entity.Sex,entity.bmName,entity.Email,entity.Phone,entity.Lxphone,entity.Sf,entity.Cs,entity.Address];
            
            NSString * sql=[NSString stringWithFormat:@"insert into [customer](%@)values(%@)",tablekey,values];
            
            NSLog(@"--------------:%@",sql);
            
            if (![self HandleSql:sql]) {
                return nil;
            }

    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        //[self closeDB];
    }
    
    return entity;
}

//更新当前用户的基本信息
-(customer*)updateCustomer:(customer *)entity{
    
    @try {
        
        //先调接口更新服务器的信息先
        customerApi * api=[[customerApi alloc] init];

        if([api updateCustomer:entity]){
            //先删除之前的用户信息
            //[self ClearTableDatas:[NSString stringWithFormat:@" customer where uId='%@'",entity.uId]];
//            NSString * sql0=[NSString stringWithFormat:@"delete from customer where uId=%@ ",entity.uId];
//            
//            NSLog(@"--------------:%@",sql0);
//            [self HandleSql:sql0];
            
            NSString *tablekey=@"uId,userType,userName,userPass,userDueDate,userTrueName,sfUrl,lxrName,Sex,bmName,Email,Phone,Lxphone,Sf,Cs,Address";
            
            NSString * values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",entity.uId,entity.userType,entity.userName,entity.userPass,entity.userDueDate,entity.userTrueName,entity.sfUrl,entity.lxrName,entity.Sex,entity.bmName,entity.Email,entity.Phone,entity.Lxphone,entity.Sf,entity.Cs,entity.Address];
            
            NSString * sql=[NSString stringWithFormat:@"insert into [customer](%@)values(%@)",tablekey,values];
            
            NSLog(@"--------------:%@",sql);
            
            if (![self HandleSql:sql]) {
                return nil;
            }
        }else
            return nil;

        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return entity;
}

//更新当前用户的密码
-(customer*)updateCustomerPasswrod:(customer *)entity{
    
    @try {
        
        //先调接口更新服务器的信息先
        customerApi * api=[[customerApi alloc] init];
        
        if([api updateCustomerPassword:entity]){
        
            NSString * sql=[NSString stringWithFormat:@"update customer set userPass='%@' where uId=%@",entity.userPass,entity.uId];
        
            NSLog(@"--------------:%@",sql);
        
            if (![self execSqlandClose:sql]) {
                return nil;
            }
            
        }else
            return nil;
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return entity;
}

//查询当前公司的资料
-(myinfo*)getMyinfo:(NSString *)code{
    
    myinfo * entity = [[myinfo alloc] init];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT uId,logopath,details,name,logopathsm,companycode from myinfo where companycode=%@ ",code];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return entity;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char * uId   = (char *)sqlite3_column_text(statement,0);
                if(uId != nil)
                    entity.uId = [NSString stringWithUTF8String:uId];
                
                char * logopath   = (char *)sqlite3_column_text(statement,1);
                if(logopath != nil)
                    entity.logopath = [NSString stringWithUTF8String:logopath];
                
                char * details   = (char *)sqlite3_column_text(statement,2);
                if(details != nil)
                    entity.details = [NSString stringWithUTF8String:details];
                
                char * name   = (char *)sqlite3_column_text(statement,3);
                if(name != nil)
                    entity.name = [NSString stringWithUTF8String:name];
                
                char * logopathsm   = (char *)sqlite3_column_text(statement,4);
                if(logopathsm != nil)
                    entity.logopathsm = [NSString stringWithUTF8String:logopathsm];
                
                char * companycode   = (char *)sqlite3_column_text(statement,5);
                if(companycode != nil)
                    entity.companycode = [NSString stringWithUTF8String:companycode];
                
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return entity;
}

//更新当前当前公司的资料
-(myinfo*)updateMyinfo:(myinfo *)entity{
    
    @try {
            
            NSString * sql=[NSString stringWithFormat:@"update myinfo set logopath='%@',logopathsm='%@',name='%@' where uId=%@",entity.logopath,entity.logopathsm,entity.name,entity.uId];
            
            NSLog(@"--------------:%@",sql);
            
            if (![self execSqlandClose:sql]) {
                return nil;
            }

    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return entity;
}

//查询镶口数据
-(NSMutableArray*)getwithmouths:(NSString *)pid{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Proid,zWeight,AuWeight,ptWeight,IsComm,Pro_number,Model,fsweight from withmouth where Proid=%@ ",pid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                withmouth * entity = [[withmouth alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Proid   = (char *)sqlite3_column_text(statement,1);
                if(Proid != nil)
                    entity.Proid = [NSString stringWithUTF8String:Proid];
                
                char * zWeight   = (char *)sqlite3_column_text(statement,2);
                if(zWeight != nil)
                    entity.zWeight = [NSString stringWithUTF8String:zWeight];
                
                char * AuWeight   = (char *)sqlite3_column_text(statement,3);
                if(AuWeight != nil)
                    entity.AuWeight = [NSString stringWithUTF8String:AuWeight];
                
                char * ptWeight   = (char *)sqlite3_column_text(statement,4);
                if(ptWeight != nil)
                    entity.ptWeight = [NSString stringWithUTF8String:ptWeight];
                
                char * IsComm   = (char *)sqlite3_column_text(statement,5);
                if(IsComm != nil)
                    entity.IsComm = [NSString stringWithUTF8String:IsComm];
                
                char * Pro_number   = (char *)sqlite3_column_text(statement,6);
                if(Pro_number != nil)
                    entity.Pro_number = [NSString stringWithUTF8String:Pro_number];
                
                char * Model   = (char *)sqlite3_column_text(statement,7);
                if(Model != nil)
                    entity.Model = [NSString stringWithUTF8String:Model];
                
                char * fsweight   = (char *)sqlite3_column_text(statement,8);
                if(fsweight != nil)
                    entity.fsweight = [NSString stringWithUTF8String:fsweight];
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//提交当前用户的订单
-(NSString*)saveOrder:(NSString *)customerid{
    
    @try {

    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,productid,pcolor,pcount,pdetail,psize,pprice,customerid,producttype,pvvs,pweight,pgoldtype,photos,photom,photob,pname,Dia_Z_weight,Dia_Z_count,Dia_F_weight,Dia_F_count,pro_model from buyproduct where customerid=%@ ",customerid];
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return @"查询购物车信息失败";
        } else {

            NSMutableString *CPInfo=[[NSMutableString alloc] init];
            NSMutableString *DZInfo=[[NSMutableString alloc] init];
            NSMutableArray *localInfo = [NSMutableArray arrayWithCapacity:10];
            
            NSMutableArray * uploadpath=[NSMutableArray arrayWithCapacity:10];//需要上传的图片路径
            
            [CPInfo appendString:@"{\"value\":["];//商品数组
            [DZInfo appendString:@"{\"value\":["];//高级定制
            
            int CPInfocount=0;
            int DZInfocount=0;
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char * producttype   = (char *)sqlite3_column_text(statement,8);//类型 1戒托 2商品 3裸钻 9高级定制 10本地商品
                NSString *  type= [NSString stringWithUTF8String:producttype];
                
                //本地商品
                if ([type isEqualToString:@"10"]) {
                    
                    orderdetail * entity = [[orderdetail alloc] init];
                    
//                    @property (nonatomic, retain) NSString * Id;
//                    @property (nonatomic, retain) NSString * cid;//商品id
//                    @property (nonatomic, retain) NSString * name;//商品名称
//                    @property (nonatomic, retain) NSString * goldType;//商品款式
//                    @property (nonatomic, retain) NSString * size;//手寸
//                    @property (nonatomic, retain) NSString * nums;//数量
//                    @property (nonatomic, retain) NSString * Pro_model;//型号
//                    @property (nonatomic, retain) NSString * diaColor;//材质
//                    @property (nonatomic, retain) NSString * goldWeight;//金重
//                    @property (nonatomic, retain) NSString * Dia_Z_weight;//主石重
//                    @property (nonatomic, retain) NSString * Dia_Z_count;//主石数量
//                    @property (nonatomic, retain) NSString * Dia_F_weight;//副石重
//                    @property (nonatomic, retain) NSString * Dia_F_count;//副石数量
//                    @property (nonatomic, retain) NSString * goldPrice;//金价
//                    @property (nonatomic, retain) NSString * Pro_price;//商品价格
//                    @property (nonatomic, retain) NSString * logopic;//商品图片
                    
                    char * pgoldtype   = (char *)sqlite3_column_text(statement,11);//商品材质
                    if(pgoldtype != nil && ![[NSString stringWithUTF8String:pgoldtype] isEqualToString:@"(null)"]){
                        entity.goldType=[self getGoldtype:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pgoldtype]]];
                    }else
                        entity.goldType=@"";
                    
                    char * pweight   = (char *)sqlite3_column_text(statement,10);//金重
                    if(pweight != nil && ![[NSString stringWithUTF8String:pweight] isEqualToString:@"(null)"])
                        entity.goldWeight=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pweight]];
                    else
                        entity.goldWeight=@"0";
                    
                    char * Dia_Z_weight   = (char *)sqlite3_column_text(statement,16);//主石重	单位克拉
                    if(Dia_Z_weight != nil && ![[NSString stringWithUTF8String:Dia_Z_weight] isEqualToString:@"(null)"])
                        entity.Dia_Z_weight=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:Dia_Z_weight]];
                    else
                        entity.Dia_Z_weight=@"0";
                    
                    char * Dia_Z_count   = (char *)sqlite3_column_text(statement,17);//主石数量
                    if(Dia_Z_count != nil && ![[NSString stringWithUTF8String:Dia_Z_count] isEqualToString:@"(null)"])
                        entity.Dia_Z_count=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:Dia_Z_count]];
                    else
                        entity.Dia_Z_count=@"0";
                    
                    char * Dia_F_weight   = (char *)sqlite3_column_text(statement,18);//副石重	单位克拉
                    if(Dia_F_weight != nil && ![[NSString stringWithUTF8String:Dia_F_weight] isEqualToString:@"(null)"])
                        entity.Dia_F_weight=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:Dia_F_weight]];
                    else
                        entity.Dia_F_weight=@"0";
                    
                    char * Dia_F_count   = (char *)sqlite3_column_text(statement,19);//副石数量
                    if(Dia_F_count != nil && ![[NSString stringWithUTF8String:Dia_F_count] isEqualToString:@"(null)"])
                        entity.Dia_F_count=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:Dia_F_count]];
                    else
                        entity.Dia_F_count=@"0";
                    
                    @try {
                        char * psize   = (char *)sqlite3_column_text(statement,5);//手寸
                        if(psize != nil && ![[NSString stringWithUTF8String:psize] isEqualToString:@"(null)"])
                            entity.size=[NSString stringWithFormat:@"%d",[NSString stringWithUTF8String:psize].integerValue];
                        else
                            entity.size=@"0";
                    }
                    @catch (NSException *exception) {
                        entity.size=@"0";
                    }
                    
//                    char * pdetail   = (char *)sqlite3_column_text(statement,4);//刻字
//                    if(pdetail != nil && ![[NSString stringWithUTF8String:pdetail] isEqualToString:@"(null)"])
//                        entity.diaColor=[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pdetail]];//商品数组
//                    else
//                        entity.diaColor=@",\"\"";
                    
                    char * pcount   = (char *)sqlite3_column_text(statement,3);//数量
                    if(pcount != nil && ![[NSString stringWithUTF8String:pcount] isEqualToString:@"(null)"])
                        entity.nums=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pcount]];//商品数组
                    else
                        entity.nums=@"0";
                    
//                    char * pvvs   = (char *)sqlite3_column_text(statement,9);//净度
//                    if(pvvs != nil && ![[NSString stringWithUTF8String:pvvs] isEqualToString:@"(null)"])
//                        entity.diaColor=[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pvvs]];//商品数组
//                    else
//                        entity.diaColor=@",\"\"";
                    
                    char * pcolor   = (char *)sqlite3_column_text(statement,2);//颜色
                    if(pcolor != nil && ![[NSString stringWithUTF8String:pcolor] isEqualToString:@"(null)"])
                        entity.diaColor=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pcolor]];//商品数组
                    else
                        entity.diaColor=@"";
                    
                    char * pname   = (char *)sqlite3_column_text(statement,15);//名称
                    if(pname != nil && ![[NSString stringWithUTF8String:pname] isEqualToString:@"(null)"])
                        entity.name=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pname]];//商品数组
                    else
                        entity.name=@"";
                    
                    char * cid   = (char *)sqlite3_column_text(statement,1);//商品id
                    if(cid != nil && ![[NSString stringWithUTF8String:cid] isEqualToString:@"(null)"])
                        entity.cid=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:cid]];//商品数组
                    else
                        entity.cid=@"";
                    
                    char * pprice   = (char *)sqlite3_column_text(statement,6);//价格
                    if(pprice != nil && ![[NSString stringWithUTF8String:pprice] isEqualToString:@"(null)"])
                        entity.Pro_price=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pprice]];//商品数组
                    else
                        entity.Pro_price=@"";
                    
                    char * pro_model   = (char *)sqlite3_column_text(statement,20);//价格
                    if(pro_model != nil && ![[NSString stringWithUTF8String:pro_model] isEqualToString:@"(null)"])
                        entity.pro_model=[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pro_model]];//商品数组
                    else
                        entity.pro_model=@"";
                    
                    
                    //有图片，则要上传
                    char * photos   = (char *)sqlite3_column_text(statement,12);
                    if(photos != nil && ![[NSString stringWithUTF8String:photos] isEqualToString:@"(null)"])
                        entity.logopic=[NSString stringWithUTF8String:photos];
                    
                    
                    [localInfo addObject:entity];
                    
                }else if ([type isEqualToString:@"9"]) {
                    //说明是高级定制
                    //DZInfo数组参数 高级定制
                    //        1	Goldtype	Int	0	商品材质
                    //        2	goldWeight	Double	0.000	金重
                    //        3	Dia_Z_weight	Double	0.000	主石重	单位克拉
                    //        4	Dia_Z_count	Int	0	主石数量
                    //        5	Dia_F_weight	Double	0.000	副石重	单位克拉
                    //        6	Dia_F_count	Int	0	副石数量
                    //        7	size	Double	0.0	手寸
                    //        8	Kz	String	“”	刻字
                    //        9	nums	Int	1	数量
                    //        10	diaClar	String	“”	净度	2013/10/24新增
                    //        11	diaColor	String	“”	颜色	2013/10/24新增
                    
                    if(DZInfocount>0)[DZInfo appendString:@","];//高级定制
                    [DZInfo appendString:@"["];//高级定制
                    
                    char * pgoldtype   = (char *)sqlite3_column_text(statement,11);//商品材质
                    if(pgoldtype != nil && ![[NSString stringWithUTF8String:pgoldtype] isEqualToString:@"(null)"]){
                       [DZInfo appendString:@"\""];
                        [DZInfo appendString:[self getGoldtype:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pgoldtype]]]];
                        [DZInfo appendString:@"\""];
                    }else
                        [DZInfo appendString:@"\"\""];
                    
                    char * pweight   = (char *)sqlite3_column_text(statement,10);//金重
                    if(pweight != nil && ![[NSString stringWithUTF8String:pweight] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pweight]]];
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    char * Dia_Z_weight   = (char *)sqlite3_column_text(statement,16);//主石重	单位克拉
                    if(Dia_Z_weight != nil && ![[NSString stringWithUTF8String:Dia_Z_weight] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:Dia_Z_weight]]];
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    char * Dia_Z_count   = (char *)sqlite3_column_text(statement,17);//主石数量
                    if(Dia_Z_count != nil && ![[NSString stringWithUTF8String:Dia_Z_count] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:Dia_Z_count]]];
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    char * Dia_F_weight   = (char *)sqlite3_column_text(statement,18);//副石重	单位克拉
                    if(Dia_F_weight != nil && ![[NSString stringWithUTF8String:Dia_F_weight] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:Dia_F_weight]]];
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    char * Dia_F_count   = (char *)sqlite3_column_text(statement,19);//副石数量
                    if(Dia_F_count != nil && ![[NSString stringWithUTF8String:Dia_F_count] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:Dia_F_count]]];
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    @try {
                        char * psize   = (char *)sqlite3_column_text(statement,5);//手寸
                        if(psize != nil && ![[NSString stringWithUTF8String:psize] isEqualToString:@"(null)"])
                            [DZInfo appendString:[NSString stringWithFormat:@",\"%d\"",[NSString stringWithUTF8String:psize].integerValue]];
                        else
                            [DZInfo appendString:@",\"0\""];
                    }
                    @catch (NSException *exception) {
                        [DZInfo appendString:@",\"0\""];
                    }

                    char * pdetail   = (char *)sqlite3_column_text(statement,4);//刻字
                    if(pdetail != nil && ![[NSString stringWithUTF8String:pdetail] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pdetail]]];//商品数组
                    else
                        [DZInfo appendString:@",\"\""];
                    
                    char * pcount   = (char *)sqlite3_column_text(statement,3);//数量
                    if(pcount != nil && ![[NSString stringWithUTF8String:pcount] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pcount]]];//商品数组
                    else
                        [DZInfo appendString:@",\"0\""];
                    
                    char * pvvs   = (char *)sqlite3_column_text(statement,9);//净度
                    if(pvvs != nil && ![[NSString stringWithUTF8String:pvvs] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pvvs]]];//商品数组
                    else
                        [DZInfo appendString:@",\"\""];
                    
                    char * pcolor   = (char *)sqlite3_column_text(statement,2);//颜色
                    if(pcolor != nil && ![[NSString stringWithUTF8String:pcolor] isEqualToString:@"(null)"])
                        [DZInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pcolor]]];//商品数组
                    else
                        [DZInfo appendString:@",\"\""];
                    
                    [DZInfo appendString:@"]"];//高级定制
                    
                    //有图片，则要上传
                    char * photos   = (char *)sqlite3_column_text(statement,12);
                    if(photos != nil && ![[NSString stringWithUTF8String:photos] isEqualToString:@"(null)"])
                        [uploadpath addObject:[NSString stringWithUTF8String:photos]];
                    
                    char * photom   = (char *)sqlite3_column_text(statement,13);
                    if(photom != nil && ![[NSString stringWithUTF8String:photom] isEqualToString:@"(null)"])
                        [uploadpath addObject:[NSString stringWithUTF8String:photom]];
                    
                    char * photob   = (char *)sqlite3_column_text(statement,14);
                    if(photob != nil && ![[NSString stringWithUTF8String:photob] isEqualToString:@"(null)"])
                        [uploadpath addObject:[NSString stringWithUTF8String:photob]];
                    
                    DZInfocount++;
                    
                }else{
                    //CPInfo商品数组
                    //        1	cid	Int	0	商品Id
                    //        2	Type	int	0	商品类别	1戒托 2成品 3裸钻
                    //        3	Name	String	“”	商品名称	为钻石时为：石头证书号
                    //        商品时：商品型号
                    //        4	diaWeight	Double	0.00	商品钻重
                    //        5	goldType	Int	0	材质
                    //        6	size	Double	0.00	手寸
                    //        7	Kz	String	“”	刻字
                    //        8	nums	Int	1	数量
                    //        9	diaClar	String	“”	净度	2013/10/24新增
                    //        10	diaColor	String	“”	颜色	2013/10/24新增
                    
                    if(CPInfocount>0)[CPInfo appendString:@","];
                    [CPInfo appendString:@"["];//商品数组
                    
                    char * productid   = (char *)sqlite3_column_text(statement,1);//商品Id
                    if(productid != nil && ![[NSString stringWithUTF8String:productid] isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@"\"%@\"",[NSString stringWithUTF8String:productid]]];//商品数组
                    else
                        [CPInfo appendString:@"\"\""];
                    
                    //商品类别1戒托 2成品 3裸钻
                    if(type != nil && ![type isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",type]];//商品数组
                    else [CPInfo appendString:@",\"1\""];
                    
                    char * pname   = (char *)sqlite3_column_text(statement,15);//商品名称	为钻石时为：石头证书号
                    if(pname != nil && ![[NSString stringWithUTF8String:pname] isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pname]]];//商品数组
                    else
                        [CPInfo appendString:@",\"\""];
                    
                    char * pweight   = (char *)sqlite3_column_text(statement,10);//商品钻重
                    if(pweight != nil && ![[NSString stringWithUTF8String:pweight] isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pweight]]];//商品数组
                    else
                        [CPInfo appendString:@",\"0\""];
                    
                    char * pgoldtype   = (char *)sqlite3_column_text(statement,11);//材质
                    if(pgoldtype != nil && ![[NSString stringWithUTF8String:pgoldtype] isEqualToString:@"(null)"]){
                        [CPInfo appendString:@",\""];
                        [CPInfo appendString:[self getGoldtype:[NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:pgoldtype]]]];//商品数组
                        [CPInfo appendString:@"\""];
                    }else
                        [CPInfo appendString:@",\"\""];
                    
                    @try {
                        char * psize   = (char *)sqlite3_column_text(statement,5);//手寸
                        if(psize != nil && ![[NSString stringWithUTF8String:psize] isEqualToString:@"(null)"])
                            [CPInfo appendString:[NSString stringWithFormat:@",\"%d\"",[NSString stringWithUTF8String:psize].integerValue]];//商品数组
                        else
                            [CPInfo appendString:@",\"0\""];
                    }
                    @catch (NSException *exception) {
                        [CPInfo appendString:@",\"0\""];
                    }
                    
                    char * pdetail   = (char *)sqlite3_column_text(statement,4);//刻字
                    if(pdetail != nil && ![[NSString stringWithUTF8String:pdetail] isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pdetail]]];//商品数组
                    else
                        [CPInfo appendString:@",\"\""];
                    
                    char * pcount   = (char *)sqlite3_column_text(statement,3);//数量
                    if(pcount != nil && ![[NSString stringWithUTF8String:pcount] isEqualToString:@"(null)"])
                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pcount]]];//商品数组
                    else
                        [CPInfo appendString:@",\"0\""];
                    
//                    char * pvvs   = (char *)sqlite3_column_text(statement,9);//净度
//                    if(pvvs != nil && ![[NSString stringWithUTF8String:pvvs] isEqualToString:@"(null)"])
//                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pvvs]]];//商品数组
//                    else
                        [CPInfo appendString:@",\"\""];
                    
//                    char * pcolor   = (char *)sqlite3_column_text(statement,2);//颜色
//                    if(pcolor != nil && ![[NSString stringWithUTF8String:pcolor] isEqualToString:@"(null)"])
//                        [CPInfo appendString:[NSString stringWithFormat:@",\"%@\"",[NSString stringWithUTF8String:pcolor]]];//商品数组
//                    else
                        [CPInfo appendString:@",\"\""];
                    
                    [CPInfo appendString:@"]"];//商品数组
                    
                    CPInfocount++;
                }
            }
            
            [CPInfo appendString:@"]}"];
            [DZInfo appendString:@"]}"];
            
            NSLog(@"CPInfo------%@",CPInfo);
            NSLog(@"DZInfo------%@",DZInfo);
            
            //如果有本地商品，则先保存到本地订单里面
            BOOL islocal=FALSE;
            if([localInfo count]>0){
                
                islocal=[self saveLocalOrder:localInfo];
            }
            
            sqlite3_finalize(statement);
            sqlite3_close(_database);

            //如果有数据，则提交定义，否则不提交
            if(CPInfocount>0 || DZInfocount>0){
                //提交到接口
                //orderApi * order=[[orderApi alloc] init];
                 AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
                [app submitOrder:CPInfo DZInfo:DZInfo uploadpath:uploadpath];
            }else{
                if(!islocal){
                    return @"购物车没有可生成订单的信息";
                }else{
                    //
                    return @"local";
                }
            }
            
        }
        
        @try {
//            sqlite3_finalize(statement);
//            sqlite3_close(_database);
        }
        @catch (NSException *exception) {
            
        }
        
    }
    
    }
    @catch (NSException *exception) {
        return @"查询购物车信息失败";
    }
    @finally {
        
    }
    
    return @"" ;
}

//保存本地订单
- (BOOL)saveLocalOrder:(NSMutableArray *)localInfo{

    if([localInfo count]>0){
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
        //用[NSDate date]可以获取系统当前时间
        NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
        
        AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
        NSString * orderid=currentDateStr;
        
        //实例化一个NSDateFormatter对象
        NSDateFormatter *createdate = [[NSDateFormatter alloc] init];
        //设定时间格式,这里可以设置成自己需要的格式
        [createdate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        //用[NSDate date]可以获取系统当前时间
        NSString *createdatestring = [createdate stringFromDate:[NSDate date]];
        
        
        NSString *tablekey=@"Id,uId,username,mobile,phone,addr,comtents,createdate,allprice,getprice";
        
        NSString * values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",orderid,myDelegate.entityl.uId,myDelegate.entityl.userName,myDelegate.entityl.Phone,myDelegate.entityl.Phone,myDelegate.entityl.Address,@"",createdatestring,@"0",@"0"];
        
        NSString * sql=[NSString stringWithFormat:@"insert into [orderbill](%@)values(%@)",tablekey,values];
        
        NSLog(@"--------------:%@",sql);
        
        //保存订单表头
        if ([self execSql:sql]) {
            
            int count = [localInfo count];
            //遍历这个数组 保存订单的明细商品
            for (int i = 0; i < count; i++) {
                orderdetail * entity =[localInfo objectAtIndex: i];
                
                NSString * did=[NSString stringWithFormat:@"%@%d",orderid,i];
            tablekey=@"Id,orderid,cid,name,goldType,size,nums,Pro_model,diaColor,goldWeight,Dia_Z_weight,Dia_Z_count,Dia_F_weight,Dia_F_count,goldPrice,Pro_price,logopic";
                
                values =[NSString stringWithFormat:@"'%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@'",did,orderid,entity.cid,entity.name,entity.goldType,entity.size,entity.nums,entity.Pro_model,entity.diaColor,entity.goldWeight,entity.Dia_Z_weight,entity.Dia_Z_count,entity.Dia_F_weight,entity.Dia_F_count,entity.goldPrice,entity.Pro_price,entity.logopic];
                
                sql=[NSString stringWithFormat:@"insert into [orderdetail](%@)values(%@)",tablekey,values];
                
                [self execSql:sql];
            }
            
            return TRUE;
        }
        
    }
    return FALSE;
}


//清空数据
- (BOOL)ClearAllTableDatas{
    
    @try {
        
        [self ClearTableDatas:@"product"];
        
        [self ClearTableDatas:@"productdia"];
        
        [self ClearTableDatas:@"buyproduct"];
        
        [self ClearTableDatas:@"withmouth"];
        
        [self ClearTableDatas:@"myinfo"];
        
        [self ClearTableDatas:@"customer"];
        
        [self ClearTableDatas:@"updatetime"];

        [self ClearTableDatas:@"productphotos"];

    }
    @catch (NSException *exception) {
        return FALSE;
    }
    @finally {
        
    }
    
    return TRUE;
}


//根据名称获取材质的代码值
-(NSString *)getGoldtype:(NSString *)name{

    NSString *textvalue=name;
    if ([name isEqualToString:@"18K黄"]) {
        textvalue=@"1";
    }
    else if ([name isEqualToString:@"18K白"]){
        textvalue=@"2";
    }
    else if ([name isEqualToString:@"18K双色"]){
        textvalue=@"3";
    }
    else if ([name isEqualToString:@"18K玫瑰金"]){
        textvalue=@"4";
    }
    else if ([name isEqualToString:@"PT900"]){
        textvalue=@"5";
    }
    else if ([name isEqualToString:@"PT950"]){
        textvalue=@"6";
    }
    else if ([name isEqualToString:@"PD950"]){
        textvalue=@"7";
    }
    
    return textvalue;
}

//查询本地订单列表
- (NSMutableArray*)GetLocalOrderList:(NSString *)uId page:(int)page pageSize:(int)pageSize{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL =@"SELECT Id,uId,username,mobile,phone,addr,comtents,createdate,allprice,getprice,state from orderbill ";
        if (uId.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" where uId=%@ ",uId];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" order by uId limit %d offset %d ",pageSize,offsetcount]];
        
        NSLog(@"querySQL-----:%@",querySQL);
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                orderbill * entity = [[orderbill alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * uId   = (char *)sqlite3_column_text(statement,1);
                if(uId != nil)
                    entity.uId = [NSString stringWithUTF8String:uId];
                
                char * username   = (char *)sqlite3_column_text(statement,2);
                if(username != nil)
                    entity.username = [NSString stringWithUTF8String:username];
                
                char * mobile   = (char *)sqlite3_column_text(statement,3);
                if(mobile != nil)
                    entity.mobile = [NSString stringWithUTF8String:mobile];
                
                char * phone   = (char *)sqlite3_column_text(statement,4);
                if(phone != nil)
                    entity.phone = [NSString stringWithUTF8String:phone];
                
                char * addr   = (char *)sqlite3_column_text(statement,5);
                if(addr != nil)
                    entity.addr = [NSString stringWithUTF8String:addr];
                
                char * comtents   = (char *)sqlite3_column_text(statement,6);
                if(comtents != nil)
                    entity.comtents = [NSString stringWithUTF8String:comtents];
                
                char * createdate   = (char *)sqlite3_column_text(statement,7);
                if(createdate != nil)
                    entity.createdate = [NSString stringWithUTF8String:createdate];
                
                char * allprice   = (char *)sqlite3_column_text(statement,8);
                if(allprice != nil)
                    entity.allprice = [NSString stringWithUTF8String:allprice];
                
                char * getprice   = (char *)sqlite3_column_text(statement,9);
                if(getprice != nil)
                    entity.getprice = [NSString stringWithUTF8String:getprice];
                
                char * state   = (char *)sqlite3_column_text(statement,10);
                if(state != nil)
                    entity.state = [NSString stringWithUTF8String:state];
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询本地订单详情列表
- (NSMutableArray*)GetLocalOrderDetailList:(NSString *)orderid page:(int)page pageSize:(int)pageSize{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL =@"SELECT Id,orderid,cid,Name,goldType,size,nums,Pro_model,diaColor,goldWeight,Dia_Z_weight,Dia_Z_count,Dia_F_weight,Dia_F_count,goldPrice,Pro_price,logopic from orderdetail ";
        if (orderid.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" where orderid=%@ ",orderid];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" order by orderid limit %d offset %d ",pageSize,offsetcount]];
        
        NSLog(@"querySQL-----:%@",querySQL);
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                orderdetail * entity = [[orderdetail alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * orderid   = (char *)sqlite3_column_text(statement,1);
                if(orderid != nil)
                    entity.orderid = [NSString stringWithUTF8String:orderid];
                
                char * cid   = (char *)sqlite3_column_text(statement,2);
                if(cid != nil)
                    entity.cid = [NSString stringWithUTF8String:cid];
                
                char * Name   = (char *)sqlite3_column_text(statement,3);
                if(Name != nil)
                    entity.Name = [NSString stringWithUTF8String:Name];
                
                char * goldType   = (char *)sqlite3_column_text(statement,4);
                if(goldType != nil)
                    entity.goldType = [NSString stringWithUTF8String:goldType];
                
                char * size   = (char *)sqlite3_column_text(statement,5);
                if(size != nil)
                    entity.size = [NSString stringWithUTF8String:size];
                
                char * nums   = (char *)sqlite3_column_text(statement,6);
                if(nums != nil)
                    entity.nums = [NSString stringWithUTF8String:nums];
                
                char * Pro_model   = (char *)sqlite3_column_text(statement,7);
                if(Pro_model != nil)
                    entity.Pro_model = [NSString stringWithUTF8String:Pro_model];
                
                char * diaColor   = (char *)sqlite3_column_text(statement,8);
                if(diaColor != nil)
                    entity.diaColor = [NSString stringWithUTF8String:diaColor];
                
                char * goldWeight   = (char *)sqlite3_column_text(statement,9);
                if(goldWeight != nil)
                    entity.goldWeight = [NSString stringWithUTF8String:goldWeight];
                
                char * Dia_Z_weight   = (char *)sqlite3_column_text(statement,10);
                if(Dia_Z_weight != nil)
                    entity.Dia_Z_weight = [NSString stringWithUTF8String:Dia_Z_weight];
                
                char * Dia_Z_count   = (char *)sqlite3_column_text(statement,11);
                if(Dia_Z_count != nil)
                    entity.Dia_Z_count = [NSString stringWithUTF8String:Dia_Z_count];
                
                char * Dia_F_weight   = (char *)sqlite3_column_text(statement,12);
                if(Dia_F_weight != nil)
                    entity.Dia_F_weight = [NSString stringWithUTF8String:Dia_F_weight];
                
                char * Dia_F_count   = (char *)sqlite3_column_text(statement,13);
                if(Dia_F_count != nil)
                    entity.Dia_F_count = [NSString stringWithUTF8String:Dia_F_count];
                
                char * goldPrice   = (char *)sqlite3_column_text(statement,14);
                if(goldPrice != nil)
                    entity.goldPrice = [NSString stringWithUTF8String:goldPrice];
                
                char * Pro_price   = (char *)sqlite3_column_text(statement,15);
                if(nums != nil)
                    entity.Pro_price = [NSString stringWithUTF8String:Pro_price];
                
                char * logopic   = (char *)sqlite3_column_text(statement,16);
                if(logopic != nil)
                    entity.logopic = [NSString stringWithUTF8String:logopic];
                
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//删除本地订单信息
-(NSString*)deletelocalorder:(NSString *)oid{
    
    @try {
        
        NSString * sql=[NSString stringWithFormat:@"DELETE from [orderdetail] where orderid=%@",oid];
        
        NSLog(@"--------------:%@",sql);
        
        if ([self execSql:sql]) {
            sql=[NSString stringWithFormat:@"DELETE from [orderbill] where Id=%@",oid];
            if (![self HandleSql:sql]) {
                return nil;
            }
        }else
        {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        //[self closeDB];
    }
    
    return oid;
}

//修改本地订单
-(NSString *)updatelocalorder:(NSString *)key value:(NSString *)value oid:(NSString *)oid{
    
    @try {
        
        NSString * sql=[NSString stringWithFormat:@" update orderbill set %@='%@'  where Id=%@",key,value,oid];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self execSqlandClose:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return @"1";
    
}

//查询本地商品列表
- (NSMutableArray*)GetLocalProductList:(NSString *)type1 type2:(NSString *)type2 type3:(NSString *)type3 type4:(NSString *)type4 page:(int)page pageSize:(int)pageSize{
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL = [NSString stringWithFormat:@"SELECT Id,Pro_model,Pro_number,Pro_name,Pro_State,Pro_smallpic,Pro_bigpic,Pro_info,Pro_goldWeight,Pro_author,Pro_addtime,producttype from product where Pro_IsDel='0' and producttype='1'" ];
        if (type1.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Pro_Class in (%@) ",type1];
//            if ([type1 isEqualToString:@"3"]) {
//                classsql=[classsql stringByAppendingString:@" and Pro_typeWenProId=0 "];
//            }
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type2.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and Pro_goldType in (%@) ",type2];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type3.length!=0) {
            NSString *classsql=nil;
            NSArray *inlayArray=[type3 componentsSeparatedByString:@","];
            for (NSString *inlay in inlayArray) {
                NSArray *inlayfff=[inlay componentsSeparatedByString:@"-"];
                if (classsql) {
                    classsql=[classsql stringByAppendingString:@" or "];
                    classsql=[classsql stringByAppendingString:[NSString stringWithFormat:@" zWeight in (%@,%@)",[inlayfff objectAtIndex:0],[inlayfff objectAtIndex:1]]];
                }else{
                    classsql=[@" and exists( select * from withmouth where withmouth.Proid=product.Id and (zWeight " stringByAppendingString:[NSString stringWithFormat:@"in (%@,%@)",[inlayfff objectAtIndex:0],[inlayfff objectAtIndex:1]]];
                }
            }
            if(classsql){
                classsql=[classsql stringByAppendingString:@"))"];
            }
            
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        if (type4.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" and %@ ",type4];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" order by Pro_Order limit %d offset %d ",pageSize,offsetcount]];
        
        NSLog(@"querySQL-----:%@",querySQL);
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                productEntity * entity = [[productEntity alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * Pro_model   = (char *)sqlite3_column_text(statement,1);
                if(Pro_model != nil)
                    entity.Pro_model = [NSString stringWithUTF8String:Pro_model];
                
                char * Pro_number   = (char *)sqlite3_column_text(statement,2);
                if(Pro_number != nil)
                    entity.Pro_number = [NSString stringWithUTF8String:Pro_number];
                
                char * Pro_name   = (char *)sqlite3_column_text(statement,3);
                if(Pro_name != nil)
                    entity.Pro_name = [NSString stringWithUTF8String:Pro_name];
                
                char * Pro_State   = (char *)sqlite3_column_text(statement,4);
                if(Pro_State != nil)
                    entity.Pro_State = [NSString stringWithUTF8String:Pro_State];
                
                char * Pro_smallpic   = (char *)sqlite3_column_text(statement,5);
                if(Pro_smallpic != nil)
                    entity.Pro_smallpic = [NSString stringWithUTF8String:Pro_smallpic];
                
                char * Pro_bigpic   = (char *)sqlite3_column_text(statement,6);
                if(Pro_bigpic != nil)
                    entity.Pro_bigpic = [NSString stringWithUTF8String:Pro_bigpic];
                
                char * Pro_info   = (char *)sqlite3_column_text(statement,7);
                if(Pro_info != nil)
                    entity.Pro_info = [NSString stringWithUTF8String:Pro_info];
                
                char * Pro_goldWeight   = (char *)sqlite3_column_text(statement,8);
                if(Pro_goldWeight != nil)
                    entity.Pro_goldWeight = [NSString stringWithUTF8String:Pro_goldWeight];
                
                char * Pro_author   = (char *)sqlite3_column_text(statement,9);
                if(Pro_author != nil)
                    entity.Pro_author = [NSString stringWithUTF8String:Pro_author];
                
                char * Pro_addtime   = (char *)sqlite3_column_text(statement,10);
                if(Pro_addtime != nil)
                    entity.Pro_addtime = [NSString stringWithUTF8String:Pro_addtime];
                
                char * producttype   = (char *)sqlite3_column_text(statement,11);
                if(producttype != nil)
                    entity.producttype = [NSString stringWithUTF8String:producttype];
                
                
                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//查询商品类别列表
- (NSMutableArray*)GetProclassList:(NSString *)uId page:(int)page pageSize:(int)pageSize
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    
    //判断数据库是否打开
    if ([self openDB]) {
        page=page==0?1:page;
        int offsetcount=page*pageSize-1*pageSize;
        
        sqlite3_stmt *statement = nil;
        //sql语句
        NSString *querySQL =@"SELECT Id,name,uId from proclass ";
        if (uId.length!=0) {
            NSString *classsql=[NSString stringWithFormat:@" where uId=%@ ",uId];
            querySQL=[querySQL stringByAppendingString:classsql];
        }
        querySQL=[querySQL stringByAppendingString:[NSString stringWithFormat:@" order by uId limit %d offset %d ",pageSize,offsetcount]];
        
        NSLog(@"querySQL-----:%@",querySQL);
        
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            //NSLog(@"Error: failed to prepare statement with message:search TB_MyDoor.");
            return NO;
        } else {
            
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            while (sqlite3_step(statement) == SQLITE_ROW) {
                proclassEntity * entity = [[proclassEntity alloc] init];
                
                char * Id   = (char *)sqlite3_column_text(statement,0);
                if(Id != nil)
                    entity.Id = [NSString stringWithUTF8String:Id];
                
                char * name   = (char *)sqlite3_column_text(statement,1);
                if(name != nil)
                    entity.name = [NSString stringWithUTF8String:name];
                
                char * uId   = (char *)sqlite3_column_text(statement,2);
                if(uId != nil)
                    entity.uId = [NSString stringWithUTF8String:uId];

                [array addObject:entity];
            }
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return array ;
}

//删除商品类别信息
-(NSString*)deleteProclass:(NSString *)oid
{
    @try {
        
        NSString * sql=[NSString stringWithFormat:@"DELETE from [proclass] where Id=%@",oid];
        
        NSLog(@"--------------:%@",sql);
        
        if ([self execSql:sql]) {
                return oid;
        }else
        {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        //[self closeDB];
    }
    
    return oid;
}

//修改商品类别
-(NSString *)updateProclass:(NSString *)key value:(NSString *)value oid:(NSString *)oid
{
    @try {
        
        NSString * sql=[NSString stringWithFormat:@" update proclass set %@='%@'  where Id=%@",key,value,oid];
        
        NSLog(@"--------------:%@",sql);
        
        if (![self execSqlandClose:sql]) {
            return nil;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return @"1";
}

//新加商品类别
-(proclassEntity*)addProclass:(proclassEntity *)entity
{
    
    @try {
        
        NSString *tablekey=@"uId,name";
        
        NSString * values =[NSString stringWithFormat:@"'%@','%@'",entity.uId,entity.name];
        
        NSString * sql=[NSString stringWithFormat:@"insert into [proclass](%@)values(%@)",tablekey,values];
        
        NSLog(@"--------------:%@",sql);
        
        //保存商品类别
        if ([self execSqlandClose:sql]) {
            return entity;
        }
        
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
        [self closeDB];
    }
    
    return nil;
    
}

@end

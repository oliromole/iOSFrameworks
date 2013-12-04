//
//  RWSQLiteLimit.h
//  RWSQLite
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2012.06.22.
//  Copyright (c) 2012 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// Importing the system headers.
#import <Foundation/NSObjCRuntime.h>

// Importing the system headers.
#import <sqlite3.h>

typedef NS_ENUM(NSInteger, RWSQLiteLimit)
{
    RWSQLiteLimitLength            = SQLITE_LIMIT_LENGTH,              //  0 /* The maximum size of any string or BLOB or table row, in bytes */
    RWSQLiteLimitSQLLength         = SQLITE_LIMIT_SQL_LENGTH,          //  1 /* The maximum length of an SQL statement, in bytes */
    RWSQLiteLimitColumn            = SQLITE_LIMIT_COLUMN,              //  2 /* The maximum number of columns in a table definition or in the result set of a [SELECT] or the maximum number of columns in an index or in an ORDER BY or GROUP BY claus */
    RWSQLiteLimitExpressionDepth   = SQLITE_LIMIT_EXPR_DEPTH,          //  3 /* The maximum depth of the parse tree on any  expression */
    RWSQLiteLimitCompoundSelect    = SQLITE_LIMIT_COMPOUND_SELECT,     //  4 /* The maximum number of terms in a compound SELECT statement */
    RWSQLiteLimitVDBEOP            = SQLITE_LIMIT_VDBE_OP,             //  5 /* The maximum number of instructions in a virtual machine program used to implement an SQL statement.  This limit is not currently enforced, though that might be added in some future release of SQLite */
    RWSQLiteLimitFunctionArguments = SQLITE_LIMIT_FUNCTION_ARG,        //  6 /* The maximum number of arguments on a function */
    RWSQLiteLimitAttached          = SQLITE_LIMIT_ATTACHED,            //  7 /* The maximum number of [ATTACH | attached databases] */
    RWSQLiteLimitLikePatternLength = SQLITE_LIMIT_LIKE_PATTERN_LENGTH, //  8 /* The maximum length of the pattern argument to the [LIKE] or [GLOB] operators */
    RWSQLiteLimitVariableNumber    = SQLITE_LIMIT_VARIABLE_NUMBER,     //  9 /* The maximum index number of any [parameter] in an SQL statement */
    RWSQLiteLimitTriggerDapth      = SQLITE_LIMIT_TRIGGER_DEPTH        // 10 /* The maximum depth of recursion for triggers */
};

//
//  RERFC5322.m
//  REFoundation
//  https://github.com/oliromole/iOSFrameworks.git
//
//  Created by Roman Oliichuk on 2013.05.09.
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

// Importing the header.
#import "RERFC5322.h"

// Importing the system headers.
#import <Foundation/Foundation.h>

/*
 * RFC5322 Address Specification
 *-----------------------------------------------------------------------*
 | Address Specification                                                 |
 *-----------------------------------------------------------------------*
 |                                                                       |
 | SP             = %x20                                                 |
 | HTAB           = %x09                                                 |
 | WSP            = SP / HTAB                                            |
 | CR             = %x0D                                                 |
 | LF             = %x0A                                                 |
 | CRLF           = CR LF                                                |
 | obs-FWS        = 1*WSP *(CRLF 1*WSP)                                  |
 | FWS            = ([*WSP CRLF] 1*WSP) /  obs-FWS                       |
 | VCHAR          = %x21-7E                                              |
 | comment        = ";" *(WSP / VCHAR) CRLF                              |
 | CFWS           = (1*([FWS] comment) [FWS]) / FWS                      |
 | ALPHA          = %x41-5A / %x61-7A ; A-Z / a-z                        |
 | DIGIT          = %x30-39; 0-9                                         |
 | atext          = ALPHA / DIGIT /                                      |
 |                  "!" / "#" /                                          |
 |                  "$" / "%" /                                          |
 |                  "&" / "'" /                                          |
 |                  "*" / "+" /                                          |
 |                  "-" / "/" /                                          |
 |                  "=" / "?" /                                          |
 |                  "^" / "_" /                                          |
 |                  "`" / "{" /                                          |
 |                  "|" / "}" /                                          |
 |                  "~"                                                  |
 | atom           = [CFWS] 1*atext [CFWS]                                |
 | DQUOTE         = %x22 ; "                                             |
 | obs-NO-WS-CTL  = %d1-8 / %d11 / %d12 / %d14-31 / %d127                |
 | obs-qtext      = obs-NO-WS-CTL                                        |
 | qtext          = %d33 / %d35-91 / %d93-126 / obs-qtext                |
 | obs-qp         = "\" (%d0 / obs-NO-WS-CTL / LF / CR)                  |
 | quoted-pair    = ("\" (VCHAR / WSP)) / obs-qp                         |
 | qcontent       = qtext / quoted-pair                                  |
 | quoted-string  = [CFWS] DQUOTE *([FWS] qcontent) [FWS] DQUOTE [CFWS]  |
 | word           = atom / quoted-string                                 |
 | obs-phrase     = word *(word / "." / CFWS)                            |
 | phrase         = 1*word / obs-phrase                                  |
 | display-name   = phrase                                               |
 | dot-atom-text  = 1*atext *("." 1*atext)                               |
 | dot-atom       = [CFWS] dot-atom-text [CFWS]                          |
 | quoted-string  = [CFWS] DQUOTE *([FWS] qcontent) [FWS] DQUOTE [CFWS]  |
 | obs-local-part = word *("." word)                                     |
 | local-part     = dot-atom / quoted-string / obs-local-part            |
 | obs-dtext      = obs-NO-WS-CTL / quoted-pair                          |
 | dtext          = %d33-90 / %d94-126 / obs-dtext                       |
 | domain-literal = [CFWS] "[" *([FWS] dtext) [FWS] "]" [CFWS]           |
 | obs-domain     = atom *("." atom)                                     |
 | domain         = dot-atom / domain-literal / obs-domain               |
 | addr-spec      = local-part "@" domain                                |
 | obs-domain-list = *(CFWS / ",") "@" domain *("," [CFWS] ["@" domain]) |
 | obs-route      = obs-domain-list ":"                                  |
 | obs-angle-addr = [CFWS] "<" obs-route addr-spec ">"                   |
 | angle-addr     = [CFWS] "<" addr-spec ">" [CFWS] / obs-angle-addr     |
 | name-addr      = [display-name] angle-addr                            |
 | mailbox        = name-addr / addr-spec                                |
 | obs-mbox-list  = *([CFWS] ",") mailbox *("," [mailbox / CFWS])        |
 | mailbox-list   = (mailbox *("," mailbox)) / obs-mbox-list             |
 | obs-group-list = 1*([CFWS] ",") [CFWS]                                |
 | group-list     = mailbox-list / CFWS / obs-group-list                 |
 | group          = display-name ":" [group-list] ";" [CFWS]             |
 | address        = mailbox / group                                      |
 |                                                                       |
 *-----------------------------------------------------------------------*
 *
 */

@implementation NSString (NSStringRERFC5322)

@end

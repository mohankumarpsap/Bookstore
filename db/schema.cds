using {
        cuid,
        managed,
        sap.common.Currencies
} from '@sap/cds/common';

namespace tutorial.db;

entity Books : cuid, managed {
        tutorialitle : String;
        author       : Association to Authors;
        genre        : String;
        publishedAt  : Date;
        pages        : Integer;
        price        : Decimal(9, 2);
        currency     : Association to Currencies;
        stock        : Integer;
        status       : Association to BookStatus;
        Chapters     : Composition of many Chapters
                               on Chapters.book = $self;
}

entity BookStatus {
        key code        : String(1) enum {
                    Availabale = 'A';
                    Low_Stock = 'L';
                    Unavailable = 'U';
            }
            criticality : Integer;
            displaytext : String;
}

/**
 * type BookStatusCode : String(1) enum {
        Availabale = 'A';
        Low_Stock = 'L';
        Unavailable = 'U';
}
 */


entity Authors : cuid, managed {
        name  : String;
        /**
         * Unmanaged assocition- If the author has written multiple books
         */
        books : Association to many Books
                        on books.author = $self;
}

/**
 * Composition
 */
entity Chapters : cuid, managed {
        key book   : Association to Books;
            number : Integer;
            title  : String;
            pages  : Integer;

}

using {
        cuid,
        managed,
        sap.common.Currencies
} from '@sap/cds/common';

namespace tutorial.db;

entity Books : cuid, managed {
        tutorialitle : String;
        author       : Association to Authors;
        genre        : Association to Genres;
        publishedAt  : Date;
        pages        : Integer;
        price        : Decimal(9, 2);
        currency     : Association to Currencies;
        stock        : Integer;
        status       : Association to BookStatus;
        Chapters     : Composition of many Chapters
                               on Chapters.book = $self;
}


entity Genres {
        key code        : String;
            description : String;
}

/**
 * type genre : String enum {
  Fiction = 'Fiction';
  Science = 'Science';
  Cooking = 'Cooking';
  Fantasy = 'Fantasy';
  Hobby = 'Hobby';
  Adventure = 'Adventure';
  SelfHelp = 'Self-Help';
  NonFiction = 'Non-Fiction';
  Art = 'Art';
  Children = 'Children';
}
 */

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

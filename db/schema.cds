using {
        cuid,
        managed
} from '@sap/cds/common';

namespace tutorial.db;

entity Books : cuid, managed {
        tutorialitle : String;
        author       : Association to Authors;
        genre        : String;
        publishedAt  : Date;
        pages        : Integer;
        price        : Decimal(9, 2);
        Chapters     : Composition of Chapters
                               on Chapters.book = $self;
}

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
            number : Integer;
        key book   : Association to Books;
}
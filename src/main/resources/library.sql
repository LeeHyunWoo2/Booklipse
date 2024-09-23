drop table book_tbl;
drop table book_detail_tbl;
drop table category_tbl;
drop table book_category_tbl;

create table book_tbl
(
    isbn13           number(13) PRIMARY KEY,
    book             varchar2(250) NOT NULL,
    author           varchar2(250) NOT NULL,
    publisher        varchar2(150) NOT NULL,
    price            number(10),
    rentalAvailable char(1)       NOT NULL,
    photo            varchar2(250) NOT NULL,
    publicationDate date,
    reviewCount     number(6),
    averageRating   number(3, 1),
    bookCount          number(10)
);


create table book_detail_tbl
(
    isbn13           number(13) PRIMARY KEY ,
    bookDescription CLOB,
    pageCount       number(5),
    weight           varchar2(10),
    bookSize        varchar2(50),
    star5Count           char(4),
    star4Count           char(4),
    star3Count           char(4),
    star2Count           char(4),
    star1Count           char(4),
    FOREIGN KEY (isbn13) REFERENCES book_tbl (isbn13) -- 외래 키
);

create table category_tbl
(
    categoryId    number(19) PRIMARY KEY,
    categoryName  varchar2(60) NOT NULL,
    categoryLevel number(1)    NOT NULL,
    parentId      number(19)
);

CREATE TABLE book_category_tbl
(
    isbn13      number(13),                                         -- 책 ID
    categoryId number(19),                                         -- 카테고리 ID
    PRIMARY KEY (isbn13, categoryId),                              -- 복합 키
    FOREIGN KEY (isbn13) REFERENCES book_tbl (isbn13),              -- 외래 키 (책 테이블과 연결)
    FOREIGN KEY (categoryId) REFERENCES category_tbl (categoryId) -- 외래 키 (카테고리 테이블과 연결)
);

-- 책 제목(book) 에 대한 인덱스
CREATE INDEX idx_book_title ON book_tbl (book);
-- 출판일(publicationDate) 에 대한 인덱스
CREATE INDEX idx_publication_date ON book_tbl (publicationDate);
-- book_category_tbl의 isbn13 에 대한 인덱스
CREATE INDEX idx_book_category_isbn ON book_category_tbl (isbn13);
-- book_category_tbl의 categoryId 에 대한 인덱스
CREATE INDEX idx_book_categoryId ON book_category_tbl (categoryId);


SELECT b.*, bd.* FROM book_tbl b LEFT JOIN book_detail_tbl bd ON b.isbn13 = bd.isbn13
WHERE b.isbn13 = 9791186906071;
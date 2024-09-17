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
    rental_available char(1)       NOT NULL,
    photo            varchar2(250) NOT NULL,
    publication_date date,
    review_count     number(6),
    average_rating   number(2, 1),
    b_count          number(10)
);

create table book_detail_tbl
(
    isbn13           number(13) PRIMARY KEY ,
    book_description CLOB,
    page_count       number(5),
    weight           varchar2(10),
    book_size        varchar2(50),
    star_5           char(4),
    star_4           char(4),
    star_3           char(4),
    star_2           char(4),
    star_1           char(4),
    FOREIGN KEY (isbn13) REFERENCES book_tbl (isbn13) -- 외래 키
);

create table category_tbl
(
    category_id    number(19) PRIMARY KEY,
    category_name  varchar2(60) NOT NULL,
    category_level number(1)    NOT NULL,
    parent_id      number(19)
);

CREATE TABLE book_category_tbl
(
    isbn13      number(13),                                         -- 책 ID
    category_id number(19),                                         -- 카테고리 ID
    PRIMARY KEY (isbn13, category_id),                              -- 복합 키
    FOREIGN KEY (isbn13) REFERENCES book_tbl (isbn13),              -- 외래 키 (책 테이블과 연결)
    FOREIGN KEY (category_id) REFERENCES category_tbl (category_id) -- 외래 키 (카테고리 테이블과 연결)
);

-- 책 제목(book) 에 대한 인덱스
CREATE INDEX idx_book_title ON book_tbl (book);
-- 출판일(publicationDate) 에 대한 인덱스
CREATE INDEX idx_publication_date ON book_tbl (publication_date);
-- book_category_tbl의 isbn13 에 대한 인덱스
CREATE INDEX idx_book_category_isbn ON book_category_tbl (isbn13);
-- book_category_tbl의 category_id 에 대한 인덱스
CREATE INDEX idx_book_category_id ON book_category_tbl (category_id);


SELECT b.*, bd.* FROM book_tbl b LEFT JOIN book_detail_tbl bd ON b.isbn13 = bd.isbn13
WHERE b.isbn13 = 9791186906071;

SELECT *
FROM book_detail_tbl
WHERE DBMS_LOB.GETLENGTH(book_description) = (
    SELECT MAX(DBMS_LOB.GETLENGTH(book_description))
    FROM book_detail_tbl
);
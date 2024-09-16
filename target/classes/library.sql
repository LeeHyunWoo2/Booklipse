drop table book_tbl;
drop table category_tbl;
drop table book_category_tbl;


select count(*)
from book_tbl
WHERE review_count = 0;

create table book_tbl
(
    isbn13             number(13) PRIMARY KEY,
    book               varchar2(250) NOT NULL,
    author             varchar2(250) NOT NULL,
    publisher          varchar2(150)  NOT NULL,
    price              number(10),
    rental_available   char(1)       NOT NULL,
    photo              varchar2(250) NOT NULL,
    book_description   CLOB,
    page_count         number(5),
    weight             varchar2(10),
    book_size          varchar2(50),
    average_rating     number(2, 1),
    star_5             char(4),
    star_4             char(4),
    star_3             char(4),
    star_2             char(4),
    star_1             char(4),
    review_count       number(6),
    publication_date   date,
    b_count            number(10)
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
    isbn13      number(13),                                       -- 책 ID
    category_id number(19),                                       -- 카테고리 ID
    PRIMARY KEY (isbn13, category_id),                              -- 복합 키 정의
    FOREIGN KEY (isbn13) REFERENCES book_tbl (isbn13),              -- 외래 키 정의 (책 테이블과 연결)
    FOREIGN KEY (category_id) REFERENCES category_tbl (category_id) -- 외래 키 정의 (카테고리 테이블과 연결)
);

SELECT * FROM (
                  SELECT
                      ROW_NUMBER() OVER (ORDER BY b.publication_date DESC) AS rnum,
                      b.isbn13, b.book, b.author, b.publisher, b.publication_date AS publicationDate,
                      b.price, b.average_rating AS averageRating, b.review_count, b.b_count, b.photo
                  FROM book_tbl b
                           LEFT JOIN book_category_tbl bc ON b.isbn13 = bc.isbn13
                           LEFT JOIN category_tbl c ON bc.category_id = c.category_id
                  WHERE 1=1
                  ORDER BY b.publication_date DESC
              ) a
WHERE rnum BETWEEN :startRow AND :endRow;



-- 책 제목(book) 에 대한 인덱스
CREATE INDEX idx_book_title ON book_tbl(book);
-- 출판일(publicationDate) 에 대한 인덱스
CREATE INDEX idx_publication_date ON book_tbl(publication_date);
-- book_category_tbl의 isbn13 에 대한 인덱스
CREATE INDEX idx_book_category_isbn ON book_category_tbl(isbn13);
-- book_category_tbl의 category_id 에 대한 인덱스
CREATE INDEX idx_book_category_id ON book_category_tbl(category_id);


SELECT file_name, bytes / (1024 * 1024) AS size_mb
FROM dba_data_files;

SELECT
    df.tablespace_name,
    df.file_name,
    df.bytes / (1024 * 1024) AS total_size_mb,
    (df.bytes - COALESCE(fs.free_space, 0)) / (1024 * 1024) AS used_size_mb,
    COALESCE(fs.free_space, 0) / (1024 * 1024) AS free_space_mb
FROM
    dba_data_files df
        LEFT JOIN
    (SELECT
         tablespace_name,
         file_id,
         SUM(bytes) AS free_space
     FROM
         dba_free_space
     GROUP BY
         tablespace_name, file_id) fs
    ON
        df.tablespace_name = fs.tablespace_name
            AND df.file_id = fs.file_id;








SELECT *
FROM (
         SELECT
             isbn13, book, author, publisher, publication_date,
             price, average_rating, review_count, b_count, photo,
             ROWNUM AS rn -- rownum으로 임시 행 번호 부여, 이 아래에서 그 범위를 이용해 특정 데이터를 고름
         FROM (
                  SELECT
                      b.isbn13, b.book, b.author, b.publisher, b.publication_date,
                      b.price, b.average_rating, b.review_count, b.b_count, b.photo
                  FROM book_tbl b
                           LEFT JOIN book_category_tbl bc ON b.isbn13 = bc.isbn13 -- 왼쪽 테이블을 기준으로 확인
                           LEFT JOIN category_tbl c ON bc.category_id = c.category_id
                  WHERE c.category_id LIKE '1001025%'  -- 카테고리 ID가 '1001025'로 시작하는 경우
                    AND b.rental_available = 'Y'       -- 대여 가능 여부가 'Y'
                    AND b.publication_date >= ADD_MONTHS(SYSDATE, -6)  -- 최근 6개월 이내 출판
                  ORDER BY b.publication_date DESC
              )
         WHERE ROWNUM <= 20  -- 페이지의 끝행 번호까지 가져오기 (매퍼에서는 endRow 라는 변수 사용)
     )
WHERE rn > 10;  -- 페이지의 시작 행 번호를 넘어가는 데이터만 가져오기 (매퍼에서는 startrow)




create table member_tbl
(
    u_id     varchar2(20)  not null unique,
    name     varchar2(30)  not null,
    birth    number(10, 0) not null,
    phone    varchar2(30)  not null,
    email    varchar2(50)  not null,
    id       varchar2(20)  not null unique,
    pw       varchar2(20)  not null,
    nickName varchar2(20)  not null unique
);


create table board_tbl
(
    title    varchar2(20)   not null,
    category varchar2(20)   not null,
    content  varchar2(1000) not null,
    bno      number(10, 0),
    regdate  date default sysdate,
    nickName varchar2(20)   not null
);

create table book_tbl
(
    photo           varchar2(50)   not null,
    book            varchar2(50)   not null,
    author          varchar2(200)  not null,
    publisher       varchar2(50)   not null,
    price           number(20),
    genre           varchar2(30)   not null,
    summary         varchar2(1000) not null,
    b_count         number(10),
    isbn13          number(30)     not null,
    isbn10          number(20)     not null,
    publicationDate date           not null
);


select * from BOOK_TBL;



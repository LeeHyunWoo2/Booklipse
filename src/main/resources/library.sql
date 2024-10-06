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
    bookCount       number(10)
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

CREATE TABLE category_preference_tbl (
     id VARCHAR2(20) NOT NULL,           -- 유저 ID (외래키로 연결)
     categoryId NUMBER(19) NOT NULL,       -- 카테고리 ID (category_tbl과 연결)
     categoryLevel NUMBER(1) NOT NULL,     -- 카테고리 레벨 (1 = 최상위, 2 = 2차 카테고리)
     categoryName  varchar2(60),
     preferenceScore NUMBER(10, 2),        -- 선호도 점수
     updatedAt DATE DEFAULT SYSDATE,       -- 데이터 업데이트 시점
     PRIMARY KEY (id, categoryId),        -- 복합키로 유저 ID와 카테고리 ID 연결
     CONSTRAINT fk_user FOREIGN KEY (id) REFERENCES member_tbl (id),
     CONSTRAINT fk_category FOREIGN KEY (categoryId) REFERENCES category_tbl (categoryId)
);

select * from category_preference_tbl where id='test123';

drop table category_preference_tbl;

-- member 테이블 생성
create table member_tbl(
   u_id varchar2(20) not null unique,
   name varchar2(30) not null,
   birth number(10,0) not null,
   phone varchar2(30) not null,
   email varchar2(50) not null,
   id varchar2(20) not null unique,
   pw varchar2(20) not null,
   nickName varchar2(10) not null unique
);

-- alter table member_tbl add constraint pk_member primary key (u_id);

-- create sequence seq_member;

-- member 테이블 더미데이터 추가
insert into member_tbl(u_id, name, birth, phone, email, id, pw, nickName)
values ('ZRBQCC081C','테스트1', '990101', '010-1234-5678', 'mbc@naver.com', 'test123', 'test123', 'tester');
insert into member_tbl(u_id, name, birth, phone, email, id, pw, nickName)
values ('ZRBzzzzzzC','테스트2', '990102', '010-1234-9874', 'mbc@naver.com', '456789', 'test123', 'qqq');
insert into member_tbl(u_id, name, birth, phone, email, id, pw, nickName)
values ('Zeqqqwe1C','테스트3', '990103', '010-1234-0000', 'mbc@naver.com', '777777', 'test123', 'www');
insert into member_tbl(u_id, name, birth, phone, email, id, pw, nickName)
values ('ZR2411C','테스트4', '990104', '010-1234-4567', 'mbc@naver.com', '66666', 'test123', 'eee');
insert into member_tbl(u_id, name, birth, phone, email, id, pw, nickName)
values ('ZRhrdfasw081C','테스트5', '990107', '010-1234-4444', 'mbc@naver.com', '33333', 'test123', 'rrr');

drop table member_tbl;
select * from  member_tbl;
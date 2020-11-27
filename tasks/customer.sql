
-- 고객 테이블

create table tblCustomer (
    CTMID            VARCHAR(15) NOT NULL,         -- ID (PK)
    CTMPW            VARCHAR(64) NOT NULL,         -- 암호화된 비밀번호 (64자리)
    CTMNO            int(8) NOT NULL,          -- 번호
    CTMNM            VARCHAR(15) NOT NULL,          -- 이름
    ADDR             VARCHAR(100),                  -- 주소
    TEL              VARCHAR(15),                  -- 전화번호
    EMAIL            VARCHAR(30) NOT NULL ,         -- 이메일
    ZIPCODE          CHAR(5),                       -- 새로운 우편번호 (5자리)
    IS_ADMIN         CHAR(1) DEFAULT 'N',           -- 관리자 여부 (Y/N)
    JOINDATE         DATE NOT NULL,                 -- 가입일
    SALT             VARCHAR(16) NOT NULL,         -- 해시 값을 만들기 위한 값
    LAST_LOGIN         int(13),                  -- 최근 로그인
    FAILED_LOGIN_COUNT int(2),                   -- 로그인 실패 횟수
    IS_LOCK CHAR(1) DEFAULT 'N'                     -- 휴먼 계정 여부 (Y/N)
);

DROP TABLE tblcustomer;

SELECT Ftblcustomer * tblcustomer;

-- 게시판 테이블과 연동되어야 하므로 기본키를 ID로 설정
ALTER TABLE tblCustomer add CONSTRAINT TBLCUSTOMER_CTMID_PK PRIMARY KEY(CTMID);
ALTER TABLE tblCustomer ADD CONSTRAINT TBLCUSTOMER_EMAIL_UK UNIQUE(EMAIL);

-- 시퀀스tblcustomer
CREATE SEQUENCE CUSTNO_SEQ 
INCREMENT BY 1
START WITH 1
MINVALUE 1
NOCYCLE;


INSERT INTO tblCustomer (CTMID, CTMPW, CTMNO, CTMNM, EMAIL, IS_ADMIN, JOINDATE, SALT) 
<<<<<<< HEAD
    VALUES('admin', 'admin', CUSTNO_SEQ.NEXTVAL, '관리자', 'admin@projectone.co.kr', 'Y', sysdate, 'AAAABBBBCCCCDDDD');
=======
    VALUES('admin', '6df48b553264e6fd617d194e5afd76ba8d893cb0f54b1a7d8c6035317874e0b5', CUSTNO_SEQ.NEXTVAL, '������', 'admin@projectone.co.kr', 'Y', sysdate, '0d6b91ff7ea2bd9d');
>>>>>>> main

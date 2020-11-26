--*****************************************************************************
-- �� ���̺�
--*****************************************************************************
create table tblCustomer (
    CTMID            VARCHAR2(15) NOT NULL,         -- ID (PK)
    CTMPW            VARCHAR2(64) NOT NULL,         -- ��ȣȭ�� ��й�ȣ (64�ڸ�)
    CTMNO            NUMBER(8) NOT NULL,            -- ��ȣ
    CTMNM            VARCHAR2(15) NOT NULL,          -- �̸�
    ADDR             VARCHAR2(100),                  -- �ּ�
    TEL              VARCHAR2(15),                  -- ��ȭ��ȣ
    EMAIL            VARCHAR2(30) NOT NULL ,         -- �̸���
    ZIPCODE          CHAR(5),                       -- ���ο� �����ȣ (5�ڸ�)
    IS_ADMIN         CHAR(1) DEFAULT 'N',           -- ������ ���� (Y/N)
    JOINDATE         DATE NOT NULL,                 -- ������
    SALT             VARCHAR2(16) NOT NULL,         -- �ؽ� ���� ����� ���� ��
    LAST_LOGIN         NUMBER(13),                  -- �ֱ� �α���
    FAILED_LOGIN_COUNT NUMBER(2),                   -- �α��� ���� Ƚ��
    IS_LOCK CHAR(1) DEFAULT 'N'                     -- �޸� ���� ���� (Y/N)
);

-- �Խ��� ���̺�� �����Ǿ�� �ϹǷ� �⺻Ű�� ID�� ����
ALTER TABLE tblCustomer add CONSTRAINT TBLCUSTOMER_CTMID_PK PRIMARY KEY(CTMID);
ALTER TABLE tblCustomer ADD CONSTRAINT TBLCUSTOMER_EMAIL_UK UNIQUE(EMAIL);

-- ������
CREATE SEQUENCE CUSTNO_SEQ 
INCREMENT BY 1
START WITH 1
MINVALUE 1
NOCYCLE;

INSERT INTO tblCustomer (CTMID, CTMPW, CTMNO, CTMNM, EMAIL, IS_ADMIN, JOINDATE, SALT) 
    VALUES('admin', '6df48b553264e6fd617d194e5afd76ba8d893cb0f54b1a7d8c6035317874e0b5', CUSTNO_SEQ.NEXTVAL, '������', 'admin@projectone.co.kr', 'Y', sysdate, '0d6b91ff7ea2bd9d');
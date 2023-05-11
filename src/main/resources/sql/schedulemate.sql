--������ ���� ������ ������ ��
drop table schedulelist purge ;
drop table schedule purge ;
drop table member_auth purge;
drop table send purge ;
drop table member purge ;

--������ ��� ���� ���̺��
drop table persistent_logins purge;

--������ ����
drop sequence member_seq;
drop sequence send_seq;
drop sequence schedule_seq;
drop sequence schedulelist_seq;

-- member table
create table member (
    m_num number NOT NULL primary KEY, --ȸ�� �Ϸù�ȣ
     m_name varchar2(50) NOT NULL , --�̸�
     m_id varchar2(50) NOT NULL unique, --���̵�
     m_pwd varchar2(100) NOT NULL, --��й�ȣ
     m_job VARCHAR2(20) NOT NULL,--����
     m_email VARCHAR2(50) NOT NULL,--�̸���
     m_phonenumber VARCHAR2(50) NOT NULL, --�޴�����ȣ
     m_weekend number(1) DEFAULT 0 NOT NULL, --�� ������ �˸� ����
     m_daily number(1) DEFAULT 0 NOT NULL,--�Ϸ� ������ �˸� ����
     m_importantmonth number(1) DEFAULT 0 NOT NULL,--�Ѵ� �� �߿� ������ �˸� ����,
     m_botuserId VARCHAR(50) UNIQUE --�� �������̵�
);
--member sequence
create sequence member_seq
start with 1
increment by 1;

--member auth table
CREATE TABLE member_auth (
    m_num number NOT NULL,
    member_auth VARCHAR2(50) NOT NULL,
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);

-- schedule table
create table schedule (
     s_num number NOT NULL ,--schedule ��������ȣ
     m_num number NOT NULL,--member ��������ȣ(FK)
     s_date DATE NOT NULL,--������ ��¥
     s_importantschedule number, --�߿� ������ ����
    PRIMARY KEY (s_date, s_num),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--schedule sequence
create sequence schedule_seq
start with 1
increment by 1;

-- schedulelist table
create table schedulelist (
     sl_num number NOT NULL,--schedulelist ��������ȣ
     sl_plannedtime NUMBER(2),--��ȹ �ð�
     sl_plannedmin NUMBER(2),--��ȹ ��
     sl_content VARCHAR2(3000) NOT NULL,--��ȹ ����
     sl_importantschedule number, --�߿� ������ ����
     sl_category number, --������ ī�װ�
    s_date DATE NOT NULL,--������ ��¥(FK)
     s_num number NOT NULL ,--schedule ��������ȣ
    PRIMARY KEY (sl_num),
    FOREIGN KEY ( s_date, s_num ) REFERENCES schedule ( s_date, s_num )
);
--schedule sequence
create sequence schedulelist_seq
start with 1
increment by 1;

--send table
CREATE TABLE send (
    sd_num number not null , --���۰�����ȣ
    m_num number not null, --��� ������ȣ
    sd_timeToSend timestamp default current_timestamp not null, --�߼��Ϸ��� �ð�
    sd_occuredError number not null, --���� �߻� ����
    sd_errorMessage varchar2(300), --�����޽���
    sd_requestedType varchar2(100) not null,--��û�� Ÿ��
    PRIMARY KEY (sd_num),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--send sequence
create sequence send_seq
start with 1
increment by 1;

--��Ű ���� ���̺�
CREATE TABLE persistent_logins (
    username VARCHAR2(64) NOT NULL,
    series VARCHAR2(64) NOT NULL,
    token VARCHAR2(64) NOT NULL,
    last_used DATE NOT NULL,
    PRIMARY KEY (series)
);

-- ������ ��ȣ �Ѿ�� ���� ����
alter sequence member_seq nocache;
alter sequence schedule_seq nocache;
alter sequence schedulelist_seq nocache;
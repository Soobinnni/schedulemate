--������ ���� ������ ������ ��
drop table sendStatusList  purge ;
drop table schedulelist purge ;
drop table sdate purge ;
drop table member purge ;

--������ ��� ���� ���̺��
drop table persistent_logins purge;

--������ ����
drop sequence member_seq;
drop sequence sdate_seq;
drop sequence schedulelist_seq;
drop sequence sendStatusList_seq;

-- member table
create table member (
    m_num number NOT NULL primary KEY, --ȸ�� �Ϸù�ȣ
     m_id varchar2(50) NOT NULL unique, --���̵�
     m_pwd varchar2(50) NOT NULL, --��й�ȣ
     m_job VARCHAR2(20) NOT NULL,--����
     m_email VARCHAR2(50) NOT NULL,--�̸���
     m_phonenumber VARCHAR2(50) NOT NULL,--��ȭ��ȣ
     m_send_weeklyschedule number(1), --������ ������ ���ۿ���
     m_send_dailyschedule number(1), --���ϸ� ������ ���ۿ���
     m_send_importantmonthschedule number(1)--�Ѵ� �߿� ������ ���� ����
);
--member sequence
create sequence member_seq
start with 1
increment by 1;

-- schedule table
create table sdate (
     sd_num number NOT NULL primary KEY ,--schedule ��������ȣ
     m_num number NOT NULL,--member ��������ȣ(FK)
     sd_date DATE NOT NULL,--������ ��¥
     sd_importantschedule number, --�߿� ������ ����
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--schedule sequence
create sequence sdate_seq
start with 1
increment by 1;

-- schedulelist table
create table schedulelist (
     sl_num number NOT NULL primary KEY ,--schedulelist ��������ȣ
     sd_num number NOT NULL,--schedule ��������ȣ(FK)
     sl_plannedtime NUMBER(2),--��ȹ �ð�
     sl_plannedmin NUMBER(2),--��ȹ ��
     sl_content CLOB NOT NULL,--��ȹ ����
     sl_importantschedule number, --�߿� ������ ����
    FOREIGN KEY ( sd_num ) REFERENCES sdate ( sd_num )
);
--schedule sequence
create sequence schedulelist_seq
start with 1
increment by 1;

-- sendStatusList table
create table sendStatusList (
     ss_num number NOT NULL primary KEY ,--sendStatusList ��������ȣ
     m_num number NOT NULL,--member ��������ȣ(FK)
     m_weekend number(1),
     m_daily number(1),
     m_importantmonth number(1),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--sendStatusList sequence
create sequence sendStatusList_seq
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
alter sequence sdate_seq nocache;
alter sequence schedulelist_seq nocache;
alter sequence sendStatusList_seq nocache;


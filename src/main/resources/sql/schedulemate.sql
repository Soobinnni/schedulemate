--������ ���� ������ ������ ��
drop table send  purge ;
drop table schedulelist purge ;
drop table schedule purge ;
drop table member purge ;

--������ ��� ���� ���̺��
drop table persistent_logins purge;

--������ ����
drop sequence member_seq;
drop sequence schedule_seq;
drop sequence schedulelist_seq;
drop sequence send_seq;

-- member table
create table member (
    m_num number NOT NULL primary KEY, --ȸ�� �Ϸù�ȣ
     m_id varchar2(50) NOT NULL unique, --���̵�
     m_pwd varchar2(50) NOT NULL, --��й�ȣ
     m_job VARCHAR2(20) NOT NULL,--����
     m_email VARCHAR2(50) NOT NULL,--�̸���
     m_phonenumber VARCHAR2(50) NOT NULL --�޴�����ȣ
);
--member sequence
create sequence member_seq
start with 1
increment by 1;

-- schedule table
create table schedule (
     s_num number NOT NULL ,--schedule ��������ȣ
     m_num number NOT NULL,--member ��������ȣ(FK)
     s_date VARCHAR2(50) NOT NULL,--������ ��¥
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
    s_date VARCHAR2(50) NOT NULL,--������ ��¥(FK)
     s_num number NOT NULL ,--schedule ��������ȣ
    PRIMARY KEY (sl_num),
    FOREIGN KEY ( s_date, s_num ) REFERENCES schedule ( s_date, s_num )
);
--schedule sequence
create sequence schedulelist_seq
start with 1
increment by 1;

-- send table
create table send (
     sd_num number NOT NULL primary KEY ,--send ��������ȣ
     sd_weekend number(1),
     sd_daily number(1),
     sd_importantmonth number(1),
     m_num number NOT NULL,--member ��������ȣ(FK)
     s_num number NOT NULL,--member ��������ȣ(FK)
     s_date varchar2(50) NOT NULL,--schedule ��������ȣ(FK)
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num ),
    FOREIGN KEY ( s_date, s_num ) REFERENCES schedule (s_date,  s_num )
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
alter sequence send_seq nocache;
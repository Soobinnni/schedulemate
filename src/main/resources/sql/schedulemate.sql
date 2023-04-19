--삭제는 다음 순서에 따르면 됨
drop table sendStatusList  purge ;
drop table schedulelist purge ;
drop table sdate purge ;
drop table member purge ;

--순서에 상관 없는 테이블들
drop table persistent_logins purge;

--시퀀스 삭제
drop sequence member_seq;
drop sequence sdate_seq;
drop sequence schedulelist_seq;
drop sequence sendStatusList_seq;

-- member table
create table member (
    m_num number NOT NULL primary KEY, --회원 일련번호
     m_id varchar2(50) NOT NULL unique, --아이디
     m_pwd varchar2(50) NOT NULL, --비밀번호
     m_job VARCHAR2(20) NOT NULL,--직업
     m_email VARCHAR2(50) NOT NULL,--이메일
     m_phonenumber VARCHAR2(50) NOT NULL,--전화번호
     m_send_weeklyschedule number(1), --일주일 스케줄 전송여부
     m_send_dailyschedule number(1), --데일리 스케줄 전송여부
     m_send_importantmonthschedule number(1)--한달 중요 스케줄 전송 여부
);
--member sequence
create sequence member_seq
start with 1
increment by 1;

-- schedule table
create table sdate (
     sd_num number NOT NULL primary KEY ,--schedule 시퀀스번호
     m_num number NOT NULL,--member 시퀀스번호(FK)
     sd_date DATE NOT NULL,--스케줄 날짜
     sd_importantschedule number, --중요 스케줄 여부
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--schedule sequence
create sequence sdate_seq
start with 1
increment by 1;

-- schedulelist table
create table schedulelist (
     sl_num number NOT NULL primary KEY ,--schedulelist 시퀀스번호
     sd_num number NOT NULL,--schedule 시퀀스번호(FK)
     sl_plannedtime NUMBER(2),--계획 시각
     sl_plannedmin NUMBER(2),--계획 분
     sl_content CLOB NOT NULL,--계획 내용
     sl_importantschedule number, --중요 스케줄 여부
    FOREIGN KEY ( sd_num ) REFERENCES sdate ( sd_num )
);
--schedule sequence
create sequence schedulelist_seq
start with 1
increment by 1;

-- sendStatusList table
create table sendStatusList (
     ss_num number NOT NULL primary KEY ,--sendStatusList 시퀀스번호
     m_num number NOT NULL,--member 시퀀스번호(FK)
     m_weekend number(1),
     m_daily number(1),
     m_importantmonth number(1),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--sendStatusList sequence
create sequence sendStatusList_seq
start with 1
increment by 1;

--쿠키 저장 테이블
CREATE TABLE persistent_logins (
    username VARCHAR2(64) NOT NULL,
    series VARCHAR2(64) NOT NULL,
    token VARCHAR2(64) NOT NULL,
    last_used DATE NOT NULL,
    PRIMARY KEY (series)
);

-- 시퀀스 번호 넘어가는 오류 방지
alter sequence member_seq nocache;
alter sequence sdate_seq nocache;
alter sequence schedulelist_seq nocache;
alter sequence sendStatusList_seq nocache;


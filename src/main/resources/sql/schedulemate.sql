--삭제는 다음 순서에 따르면 됨
drop table schedulelist purge ;
drop table schedule purge ;
drop table member_auth purge;
drop table send purge ;
drop table member purge ;

--순서에 상관 없는 테이블들
drop table persistent_logins purge;

--시퀀스 삭제
drop sequence member_seq;
drop sequence send_seq;
drop sequence schedule_seq;
drop sequence schedulelist_seq;

-- member table
create table member (
    m_num number NOT NULL primary KEY, --회원 일련번호
     m_name varchar2(50) NOT NULL , --이름
     m_id varchar2(50) NOT NULL unique, --아이디
     m_pwd varchar2(100) NOT NULL, --비밀번호
     m_job VARCHAR2(20) NOT NULL,--직업
     m_email VARCHAR2(50) NOT NULL,--이메일
     m_phonenumber VARCHAR2(50) NOT NULL, --휴대폰번호
     m_weekend number(1) DEFAULT 0 NOT NULL, --주 스케줄 알림 여부
     m_daily number(1) DEFAULT 0 NOT NULL,--하루 스케줄 알림 여부
     m_importantmonth number(1) DEFAULT 0 NOT NULL,--한달 전 중요 스케줄 알림 여부,
     m_botuserId VARCHAR(50) UNIQUE --봇 유저아이디
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
     s_num number NOT NULL ,--schedule 시퀀스번호
     m_num number NOT NULL,--member 시퀀스번호(FK)
     s_date DATE NOT NULL,--스케줄 날짜
     s_importantschedule number, --중요 스케줄 여부
    PRIMARY KEY (s_date, s_num),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--schedule sequence
create sequence schedule_seq
start with 1
increment by 1;

-- schedulelist table
create table schedulelist (
     sl_num number NOT NULL,--schedulelist 시퀀스번호
     sl_plannedtime NUMBER(2),--계획 시각
     sl_plannedmin NUMBER(2),--계획 분
     sl_content VARCHAR2(3000) NOT NULL,--계획 내용
     sl_importantschedule number, --중요 스케줄 여부
     sl_category number, --스케줄 카테고리
    s_date DATE NOT NULL,--스케줄 날짜(FK)
     s_num number NOT NULL ,--schedule 시퀀스번호
    PRIMARY KEY (sl_num),
    FOREIGN KEY ( s_date, s_num ) REFERENCES schedule ( s_date, s_num )
);
--schedule sequence
create sequence schedulelist_seq
start with 1
increment by 1;

--send table
CREATE TABLE send (
    sd_num number not null , --전송고유번호
    m_num number not null, --멤버 고유번호
    sd_timeToSend timestamp default current_timestamp not null, --발송하려던 시각
    sd_occuredError number not null, --오류 발생 여부
    sd_errorMessage varchar2(300), --오류메시지
    sd_requestedType varchar2(100) not null,--요청된 타입
    PRIMARY KEY (sd_num),
    FOREIGN KEY ( m_num ) REFERENCES member ( m_num )
);
--send sequence
create sequence send_seq
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
alter sequence schedule_seq nocache;
alter sequence schedulelist_seq nocache;
create table schedule
(
    id          bigint auto_increment comment 'Khóa chính'
        primary key,
    user_id     bigint       null comment 'ID người dùng (FK user)',
    store_id    bigint       null comment 'ID cửa hàng (FK store)',
    store_name  varchar(250) null comment 'Tên cửa hàng (cache)',
    shift_date  datetime     null comment 'Ngày làm việc',
    shift_time  varchar(50)  null comment 'Ca làm việc (sáng/chiều/đêm)',
    start_time  datetime     null comment 'Giờ bắt đầu ca',
    end_time    datetime     null comment 'Giờ kết thúc ca',
    status      tinyint(1)   null comment 'Trạng thái lịch làm việc',
    description varchar(250) null comment 'Ghi chú ca làm',
    create_at   datetime     null comment 'Thời gian tạo',
    update_by   bigint       null comment 'ID người cập nhật',
    update_at   datetime     null comment 'Thời gian cập nhật',
    create_by   bigint       null comment 'ID người tạo',
    constraint schedule_ibfk_1
        foreign key (user_id) references user (id)
)
    comment 'Bảng lưu lịch làm việc/ca làm của nhân viên';

create index store_id
    on schedule (store_id);

create index user_id
    on schedule (user_id);


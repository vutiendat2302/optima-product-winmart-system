create table notification_reciption
(
    id              bigint auto_increment comment 'Khóa chính'
        primary key,
    notification_id bigint null comment 'ID thông báo (FK notification)',
    user_id         bigint null comment 'ID người nhận (FK user)',
    constraint notification_reciption_ibfk_1
        foreign key (notification_id) references notification (id),
    constraint notification_reciption_ibfk_2
        foreign key (user_id) references user (id)
)
    comment 'Bảng ánh xạ thông báo với người nhận, hỗ trợ gửi nhiều người';

create index notification_id
    on notification_reciption (notification_id);

create index user_id
    on notification_reciption (user_id);


create table inventory
(
    id         bigint auto_increment comment 'Khóa chính, định danh kho'
        primary key,
    contact_id bigint     null comment 'ID liên hệ kho',
    create_by  bigint     null comment 'ID người tạo',
    create_at  datetime   null comment 'Thời gian tạo',
    update_by  bigint     null comment 'ID người cập nhật',
    update_at  datetime   null comment 'Thời gian cập nhật',
    status     tinyint(1) null comment 'Trạng thái kho: true = hoạt động',
    constraint inventory_ibfk_1
        foreign key (contact_id) references contact (id)
)
    comment 'Bảng lưu thông tin các kho tổng/kho chi nhánh';

create index contact_id
    on inventory (contact_id);


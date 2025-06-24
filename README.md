



## 1. High Level Design:

``` mermaid
    flowchart BT
        subgraph frontend
            FE[frontend]
            W1[web/admin ui]
            W1 <--> FE
        end

        subgraph backend
            BE[backend]
            FM[forecast] <--> SM
            SM[module]
            SMH[store-management] <--> SM
            EMH[employee-management] <--> SM
            CMH[customer-management] <--> SM
            WMH[inventory-management] <--> SM
            SC[schedule] <--> SM
            DB[database]
            SV[aws-s3] <--> SM
        end

        BE <--> FE
        SM <--> BE
        DB <--> BE
        
```



## 2. User Roles:
|Vai trò| Nhiệm vụ|

- super-admin
- regional-manager
- area-manager
- store-manager
- inventory-manager
- warehouse-staff
- pos-cashier
- accountant
- customer-support
- marketing-officer

|User Roles              | Task                                                            |
|-----------------------|-------------------------------------------------------------------------|
| super-admin           | Quản lý toàn bộ hệ thống, cấp quyền truy cập, giám sát và bảo trì.      |
| regional-manager      | Quản lý các khu vực, điều phối giữa các chi nhánh khu vực và báo cáo.   |
| area-manager          | Giám sát các cửa hàng trong khu vực, báo cáo.     |
| store-manager         | Quản lý hoạt động hàng ngày của cửa hàng, nhân viên và doanh thu.       |
| inventory-manager     | Quản lý kho theo khu vực, thống kê, báo cáo.            |
| warehouse-staff       | Thực hiện nhập kho, xuất kho, sắp xếp và kiểm tra hàng hóa.             |
| pos-cashier           | Xử lý giao dịch tại quầy, quản lý thanh toán và hỗ trợ khách hàng.      |
| accountant            | Quản lý tài chính, lập báo cáo thu chi và kiểm toán.                    |
| customer-support      | Hỗ trợ khách hàng, xử lý khiếu nại và cung cấp thông tin dịch vụ.       |
| marketing-officer     | Lên kế hoạch quảng cáo, tiếp thị sản phẩm và xây dựng chiến lược thương hiệu. |

### Diagram Roles:

``` mermaid
graph TD
     SA[Super Admin]
    RM[Regional Manager]
    AM[Area Manager]
    SM[Store Manager]
    IM[Inventory Manager]
    SS[Warehouse Staff]
    PC[POS Cashier]
    AC[Accountant]
    MO[Marketing Officer]
    CS[Support Staff]

    SA --> RM
    SA --> AC
    AC --> AM
    RM --> AM
    AM --> SM
    SM --> PC
    SM --> CS
    SM --> MO
    AM --> IM
    IM --> SS
```

### Use Case Diagram:
``` mermaid
graph LR
    SA[super_admin] --> R1[Quản lý hệ thống]
    SA --> R3[Xem báo cáo toàn chuỗi, vùng, cửa hàng]
    SA --> R4[Phân quyền] --> ADD[Thêm, sửa, xóa, quản lý, nhân viên]
    SA --> M1[Quản lý cửa hàng] --> M1_1[Thêm, sửa, xóa cửa hàng, danh mục]
    SA --> M2[Quản lý  kho]
    SA --> M2_1[Quản lý lịch làm việc]
    SA --> M2_2[Quản lý thông tin users]
    SA --> M2_3[Quản lý vocher, chiến dịch quảng cáo]

    RM[regional_manager] --> R6[Xem báo cáo vùng]
    RM --> R7[Quản lý Area Manager]
    RM --> R8[Phê duyệt tồn kho vùng, theo dõi hàng tồn kho]
    RM --> M3[Quản lý nhân viên] --> M3_1[Thêm, sửa, xóa, nhân viên]
    RM --> M3_2[Quản lý lịch làm việc của nhân viên]
    RM --> M3_3[Quản lý doanh thu của cửa hàng theo vùng]

    AM[area_manager] --> R9[Quản lý cửa hàng khu vực]
    AM --> R10[Theo dõi tồn kho]
    AM --> R11[Quản lý lịch làm việc của nhân viên]
    AM --> R11_1[Quản lý doanh thu của cửa hàng theo khu vực]

    SM[store_manager] --> R12[Quản lý kho cửa hàng]
    SM --> R13[Quản lý nhân viên cửa hàng]
    SM --> R14[Xem doanh thu cửa hàng, lịch sử giao dịch của cửa hàng]
    SM --> R14_1[Quản lý vocher, chiến dịch quảng cáo]

    IM[inventory_manager] --> R15[Điều phối hàng hóa]
    IM --> R16[Kiểm kê kho]
    IM --> R16_1[Quản lý lịch vận chuyển]

    SS[warehouse_taff] --> R17[Nhập hàng]
    SS --> R18[Xuất hàng]
    SS --> R18_1[Kiểm kê hàng]

    PC[pos_cashier] --> R19[Tạo hóa đơn]
    PC --> R20[Bán hàng tại quầy]
    PC --> R21[Nhập thông tin khách hàng]

    AC[accountant] --> R21[Xem báo cáo tài chính]
    AC --> R22[Kiểm soát dòng tiền]
    AC --> R22_1[Kiểm toán]
    AC --> R22_2[Quản lý voucher, chiến dịch quảng cáo]

    CS[support_staff] --> R23[Trả lời khách hàng]
    CS --> R24[Tra cứu đơn hàng]
    CS --> R23_1[Xem thông tin khách hàng]
    CS --> R23_2[Nhập thông tin khách hàng]

    MO[marketing_officer] --> R25[Tạo voucher]
    MO --> R26[Tạo chiến dịch quảng cáo]

```

### Use Case Overview:
``` mermaid
graph TB

    %% Actor
    super_admin([super_admin])
    regional_manager([regional_manager])
    area_manager([area_manager])
    store_manager([store_manager])
    inventory_manager([inventory_manager])
    warehouse_staff([warehouse_staff])
    pos_cashier([pos_cashier])
    accountant([accountant])
    support_staff([support_staff])
    marketing_officer([marketing_officer])

    %% Use cases (elipses)
    uc1((quản lý hệ thống))
    uc2((xem báo cáo))
    uc3((phân quyền))
    uc4((quản lý cửa hàng, danh mục))
    uc5((quản lý kho))
    uc6((quản lý lịch làm việc))
    uc7((quản lý nhân viên))
    uc8((tạo voucher, quảng cáo))
    uc9((tạo hóa đơn))
    uc10((bán hàng tại quầy))
    uc11((nhập thông tin khách hàng))
    uc12((nhập hàng))
    uc13((xuất hàng))
    uc14((kiểm kê hàng))
    uc15((kiểm toán))
    uc16((chăm sóc khách hàng))
    uc17((tra cứu đơn hàng))

    %% Mối quan hệ
    super_admin --> uc1
    super_admin --> uc2
    super_admin --> uc3
    super_admin --> uc4
    super_admin --> uc5
    super_admin --> uc6
    super_admin --> uc7
    super_admin --> uc8

    regional_manager --> uc2
    regional_manager --> uc5
    regional_manager --> uc6
    regional_manager --> uc7

    area_manager --> uc2
    area_manager --> uc5
    area_manager --> uc6
    area_manager --> uc7

    store_manager --> uc2
    store_manager --> uc5
    store_manager --> uc6
    store_manager --> uc7
    store_manager --> uc8

    inventory_manager --> uc5
    inventory_manager --> uc12
    inventory_manager --> uc13
    inventory_manager --> uc14

    warehouse_staff --> uc12
    warehouse_staff --> uc13
    warehouse_staff --> uc14

    pos_cashier --> uc9
    pos_cashier --> uc10
    pos_cashier --> uc11

    accountant --> uc2
    accountant --> uc15

    support_staff --> uc16
    support_staff --> uc17
    support_staff --> uc11

    marketing_officer --> uc8

```

## 3. ERD:


## 4. Sequence Dagram:

### super-admin: 
``` mermaid
sequenceDiagram
    participant super-admin
    participant system
    participant store-management
    participant employee-management
    participant customer-management
    participant inventory-management
    participant schedule
    participant forecast
    participant database
    participant aws-s3

    %% start use case
    super_admin->>system: đăng nhập hệ thống
    system->>database: xác thực thông tin

    database-->>system: trả kết quả xác thực
    system-->>super_admin: xác thực thành công

    %% Quản lý cửa hàng
    super_admin->>system: thêm, sửa, xóa cửa hàng mới
    system->>store_management: xử lý yêu cầu
    store_management->>database: ghi thông tin cửa hàng
    database-->>store_management: xác nhận
    store_management-->>system: thành công
    system-->>super_admin: thêm, sửa, xóa cửa hàng thành công

    %% Quản lý nhân viên
    super_admin->>system: thêm, sửa, xóa nhân viên
    system->>employee_management: xử lý thêm user
    employee_management->>database: lưu thông tin nhân viên
    database-->>employee_management: OK

    %% Quản lý khách hàng
    super_admin->>system: cập nhật thông tin khách hàng
    system->>customer_management: gửi yêu cầu
    customer_management->>database: cập nhật data

    %% Quản lý kho
    super_admin->>inventory_management: kiểm tra tồn kho
    inventory_management->>database: truy vấn dữ liệu kho

    %% Quản lý lịch làm việc
    super_admin->>schedule: cập nhật lịch làm việc
    schedule->>database: ghi thông tin lịch
    schedule->>schedule: tạo lịch làm việc cho nhân viên

    %% Dự báo hàng tồn
    super_admin->>forecast: yêu cầu dự báo hàng hóa
    forecast->>database: truy xuất dữ liệu lịch sử
    forecast->>aws_s3: lấy dữ liệu học máy
    aws_s3-->>forecast: trả mô hình
    forecast-->>super_admin: gửi kết quả dự báo

```




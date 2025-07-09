# WinMart SmartStore Suite 
<!-- Một công cụ thông minh cho chuỗi cửa hàng -->

# A. Project Overview:
WinMart is a supermarket chain establisher by Vingroup, a leading conglomerate in VietNam. 

### Objectives:
- Manage sales operations (employees, products, inventory, customer information, transaction history).
- Analyze retail chain data (revenue, inventory levels, best-selling/slow-moving products, promotion/voucher effectiveness, employee performance, customer ordering behavior).
- Forecast demand and revenue to optimize business decisions.

# B. Functionality: 


## 1. High Level Design:

``` mermaid
    flowchart BT
        subgraph frontend
            FE[frontend]
        end
        subgraph backend
            BE[backend]
            FM[forecast] <--> BE
            MN[manager] <--> BE
            DB[database] <--> BE
            SC[schedule] <--> BE
            PM[payment] <--> BE
        end
        BE <--> FE
        
```



## 2. User Roles:

- admin
- manager
- staff
- analyst

|User Roles              | Task                                                            |
|-----------------------|-------------------------------------------------------------------------|
| admin        | Quản lý toàn bộ hệ thống, CRUD, phân quyền |    |
| manager    | Quản lý cửa hàng, sản phẩm, kho, lịch, nhân viên, xem báo cáo |
| staff         | Nhân viên bình thường (bán hàng, thủ kho, thu ngân, ...). Thực hiện xem lịch, nhập thông tin khách hàng  |
| analyst       | Phân tích dữ liệu, dự báo. Xem, lấy dữ liệu, xuất báo cáo.    |



### Use Case Diagram:
``` mermaid
graph LR
    SA[admin] --> R1[Quản lý hệ thống]
    SA --> R3[CRUD mọi dữ liệu]
    SA --> R4[Phân quyền]
    SA --> M2_1[Quản lý lịch làm việc]
    SA --> M2_2[Quản lý thông tin users]


    RM[manager] --> R6[CRU cửa hàng mình quản lý]
    RM --> R7[CRUD nhân viên thuộc cửa hàng]
    RM --> R8[Lên lịch, duyệt lịch cho nhân viên cửa hàng]
    RM --> M3[Xem báo cáo danh số, lịch làm việc] 


    AM[staff] --> R9[R với dữ liệu cá nhân]
    AM --> R10[Xem lịch làm việc, xác nhận ca làm]
    AM --> R11[Tạo đơn bán hàng, nếu là thu ngân / nhân viên bán hàng]
    AM --> R11_1[Cập nhật hàng tồn kho, nếu là nhân viên kho]
  

    SM[analyst] --> R12[Xem dữ liệu đơn hàng, tồn kho, doanh số]
    SM --> R13[Lấy lịch sử dữ liệu bán hàng]
    SM --> R14[Xem kết quả, in kết quả]

```

## 3. Sequence Dagram:

### Đăng nhập & xác thực người dùng:

``` mermaid
sequenceDiagram
    participant FE as Frontend
    participant BE as Backend
    participant DB as Database

    FE->>BE: Gửi thông tin đăng nhập (username, password)
    BE->>DB: Truy vấn user, kiểm tra thông tin đăng nhập
    DB-->>BE: Trả về kết quả xác thực (thành công/thất bại, role)
    BE-->>FE: Trả kết quả (token, thông tin user)
```



### Đặt hàng & thanh toán: 
``` mermaid
sequenceDiagram
 
actor User as Khách hàng
participant FE as frontend
participant BE as backend
participant DB as database
participant PayS as payment

User ->> FE : Chọn sản phẩm, thêm vào giỏ hàng
User ->> FE : Nhấn "Đặt hàng"
FE ->> BE : Tạo đơn hàng (order info)
BE ->> DB : Kiểm tra tồn kho sản phẩm
DB -->> BE : Trả kết quả tồn kho
alt Nếu còn hàng
    BE ->> DB : Lưu đơn hàng, order_detail
    BE ->> FE : Thông báo xác nhận đơn hàng
    User ->> FE : Chọn phương thức thanh toán
    FE ->> BE : Gửi thông tin thanh toán
    BE ->> PayS : Xử lý thanh toán
    PayS ->> DB : Lưu thông tin giao dịch thanh toán
    PayS -->> BE : Kết quả thanh toán
    BE ->> DB : Cập nhật trạng thái đơn hàng (đã thanh toán)
    BE ->> FE : Thông báo kết quả thanh toán cho user
else Hết hàng
    BE ->> FE : Thông báo hết hàng
end

```


### Auto schedule:
``` mermaid
sequenceDiagram 
    participant frontend
   participant backend
    participant schedule_module
    participant database

opt [00:00 each day]
    backend ->> schedule_module: Tạo một requet auto lập lịch cho nhân viên 
    schedule_module ->> database: Lấy dữ liệu lịch làm việc của nhân viên
    database -->> schedule_module: Trả về thông tin lịch làm việc, ca làm
    schedule_module -->> schedule_module : Tạo lịch làm việc
    schedule_module ->> backend: Đề xuất lịch làm việc mới
    alt Nếu được duyệt
        backend ->> database: cập nhật lại lịch làm việc
        backend ->> frontend: Thông báo lịch mới cho nhân viên
    else Không được duyệt
    backend ->> schedule_module: Tạo lại lịch làm việc cho nhân viên
    end
end

```
### Auto dự báo:
``` mermaid
sequenceDiagram 

    participant backend
    participant forecast_module
    participant database

    opt [00:00 each day]
        backend ->> forecast_module: tạo request auto dự báo cho từng nhà hàng trong ngày
        forecast_module ->> database: lấy dữ liệu lịch sử, dữ liệu cần thiết
        database -->> forecast_module: trả về dữ liệu lịch sử
        forecast_module -->> forecast_module: xử lý dự báo (ngày, peak lunch, peak dinner)
        forecast_module ->> backend: trả về kết quả dự báo
        backend ->> database: lưu kết quả dự báo

    end

```

### Auto dự báo doanh thu:
``` mermaid
sequenceDiagram 

    participant backend
    participant forecast_module
    participant database

    opt [00:00 each day]
        backend ->> forecast_module: tạo request auto dự báo doanh thu cho mỗi nhà hàng
        forecast_module ->> database: lấy dữ liệu lịch sử doanh thu, số lượng khách, hoá đơn
        database -->> forecast_module: trả về dữ liệu lịch sử
        forecast_module ->> database: lấy dữ liệu promotion, event, thời tiết, ngày lễ
        database -->> forecast_module: trả về dữ liệu ảnh hưởng
        forecast_module -->> forecast_module: tiền xử lý, tổng hợp dữ liệu
        forecast_module -->> forecast_module: chạy mô hình dự báo doanh thu (theo ngày, theo ca)
        alt nếu dự báo thành công
            forecast_module -->> backend: trả kết quả dự báo doanh thu từng ca, từng ngày
            backend ->> database: lưu kết quả dự báo doanh thu
            backend ->> forecast_module: status forecast (success)
        else nếu lỗi dữ liệu hoặc dự báo thất bại
            forecast_module -->> backend: trả thông báo lỗi/dữ liệu thiếu
            backend ->> database: log lỗi dự báo doanh thu
            backend ->> forecast_module: status forecast (failed)
        end
    end

```


### Quản lý: 
``` mermaid
sequenceDiagram 

   participant frontend
    participant backend
    participant manager
    participant database


    frontend ->> backend: yêu cầu xem danh sách nhân viên
    backend ->> manager: lấy danh sách nhân viên
    manager ->> database: truy vấn danh sách nhân viên
    database -->> manager: trả về danh sách nhân viên
    manager -->> backend: trả về danh sách nhân viên
    backend ->> frontend: hiển thị danh sách nhân viên

    frontend ->> backend: gửi thông tin nhân viên mới
    backend ->> manager: tạo mới nhân viên
    manager ->> database: lưu thông tin nhân viên mới
    database -->> manager: xác nhận thêm mới
    manager -->> backend: kết quả tạo mới
    backend ->> frontend: phản hồi kết quả cho manager

    frontend ->> backend: gửi thông tin cập nhật nhân viên

```




## 6. Moudel Description: 

### a. forecast-model:
- Function: Dự đoán doanh thu, nhu cầu hàng hóa dựa trên dữ liệu lịch sử bán hàng. 

- Input: Dữ liệu lịch sử đơn hàng, dữ liệu kho, dữ liệu khách hàng.

- Output: Kết quả dự đoán. 

- Related Modules: database, inventory-management-model, schedule-model.

### b. store-management-model:
- Function: Quản lý thông tin cửa hàng (tên, địa chỉ, liên hệ, doanh thu), trạng thái hoạt động và người quản lý.

- Input: Thông tin từ người dùng hoặc hệ thống.

- Output: Danh sách cửa hàng, báo cáo doanh thu.

- Related Modules: database, inventory-management-model, user-role.
### c. employee-management-model:
- Function: Quản lý nhân viên (thêm, sửa, phân quyền, phân công).

- Input: Dữ liệu nhân viên, thông tin phân quyền từ user-role.

- Output: Danh sách nhân viên theo từng cửa hàng, vai trò cụ thể.

- Related Modules: database, user-role.
### d. customer-management-model:
- Function: Quản lý thông tin khách hàng và lịch sử mua hàng.

- Input: Thông tin đăng ký, dữ liệu đơn hàng.

- Output: Danh sách khách hàng, thống kê hành vi mua sắm.

- Related Modules: database, order (online/offline), feedback.
### e. inventory-management-model:
- Function: Theo dõi tình trạng hàng tồn, nhập hàng, phân phối hàng hóa từ kho đến cửa hàng.

- Input: Dữ liệu sản phẩm, phiếu nhập kho, dữ liệu từ import_log, import_product.

- Output: Số lượng tồn kho, cảnh báo thiếu hàng.

- Related Modules: database, product, store-management-model.
### f. schedule-model:
- Function: Lịch nhập hàng, lịch khuyến mãi hoặc sự kiện. Lên lịch vận chuyển hàng hóa tự động. Lên lịch làm việc cho nhân viên (tự động sắp xếp lại lịch làm việc khi có sự thay đổi về nhân lực).

- Input: Lịch từ quản lý, lịch sử làm việc, thông tin nhân viên.

- Output: Bảng phân công lịch theo ngày/tuần/tháng.

- Related Modules: employee-management-model, inventory-management-model.

### g. user-role:
- Function: Quản lý phân quyền người dùng, xác định ai được làm gì trong hệ thống.

- Input: Dữ liệu đăng nhập, vai trò được cấp bởi admin.

- Output: Quyền truy cập từng module, luồng xử lý.

- Related Modules: employee-management-model, store-management-model, schedule-model.

 ## 7. Technology:

> backend: framework: string boot, node.js

> frontend: react.js, javascript

> database: mysql

> cloud: aws-s3

> deploy: 

> forecasting: ml model,

> others: git, git hub
# setup-2vm

# VM и их роли

| ВМ | Роль | OC | IP |
|:---|:---|:---|:---|
| vm-backend-postgres | PostgreSQL 16 + Backend (GO) | Ubuntu 24.04 | 172.16.3.9/24 |
| vm-redis-proxy | Redis 7 + Proxy (Flask) | CentOS 7 | 172.16.3.10/24 |

## Подтверждение работоспособности

Скриншоты:
* Все сервисы запущены на VM с соответствующими IP:
* backend-postgres:
* <img width="776" height="269" alt="image" src="https://github.com/user-attachments/assets/e43094c7-1f50-48c1-9ff7-0a14b57afb83" />
* <img width="910" height="270" alt="image" src="https://github.com/user-attachments/assets/042ac423-f983-4ae4-acb4-adadee0e6c05" />
* <img width="816" height="177" alt="image" src="https://github.com/user-attachments/assets/b81dfe81-c06c-4f8c-af77-45cb567f6c17" />
* proxy-redis:
* <img width="775" height="249" alt="image" src="https://github.com/user-attachments/assets/5f2c53b2-5dbc-4c12-b949-153e50c301dd" />
* <img width="1092" height="306" alt="image" src="https://github.com/user-attachments/assets/ccaa40a7-f5b1-4e6d-be75-925177da3bca" />
* <img width="803" height="252" alt="image" src="https://github.com/user-attachments/assets/91f15bb0-0cfd-4537-8ad2-ce448286dbff" />

* Проверочные запросы с моей хостовой системы к IP proxy-vm:
* <img width="833" height="83" alt="image" src="https://github.com/user-attachments/assets/a8e7e44e-02cf-4294-af72-225be1220a51" />

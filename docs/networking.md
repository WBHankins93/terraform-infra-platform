# VPC Networking Overview

This document outlines the core networking configuration used in this platform's infrastructure. It describes how public and private subnets are routed and secured using AWS route tables, NAT gateways, and Internet Gateways.

---

## Subnet Layout

| Subnet Type    | CIDR Example  | Associated Use Case                  |
| -------------- | ------------- | ------------------------------------ |
| Public Subnet  | 10.0.1.0/24   | Load balancers (ALB), NAT Gateway    |
| Private Subnet | 10.0.101.0/24 | EKS worker nodes, internal workloads |

> Each subnet is assigned to an availability zone to support high availability and fault tolerance.

---

## Routing Tables

| Subnet Type    | Destination CIDR | Target                 | Purpose                               |
| -------------- | ---------------- | ---------------------- | ------------------------------------- |
| Public Subnet  | 0.0.0.0/0        | Internet Gateway (IGW) | Enables public internet access        |
| Private Subnet | 0.0.0.0/0        | NAT Gateway            | Enables outbound internet access only |

> **Public Route Table** allows external traffic via an Internet Gateway.
> **Private Route Table** routes outbound traffic through a NAT Gateway, keeping workloads inaccessible from the outside.

---

## Security Considerations

* Private subnets have **no direct route** to the Internet Gateway.
* EKS nodes in private subnets use the NAT Gateway to securely access:

  * Container registries (e.g., ECR, DockerHub)
  * Public APIs (e.g., GitHub, Auth0)
  * OS updates and patches
* All inbound access is restricted via **Security Groups** and **Network ACLs**.

---

## ✅ Summary

| Principle                    | Result                                                         |
| ---------------------------- | -------------------------------------------------------------- |
| Isolated compute nodes       | Internal services live in private subnets                      |
| Secure public exposure       | ALBs live in public subnets with access control                |
| Controlled outbound traffic  | NAT Gateway used by private subnets for external communication |
| Least privilege architecture | No direct access to sensitive infrastructure from the internet |

> This setup mirrors production-grade AWS architectures and supports a security-first deployment model.

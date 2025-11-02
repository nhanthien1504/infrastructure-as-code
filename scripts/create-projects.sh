#!/bin/bash

# ==============================================================================
#  SCRIPT: Onboard New Projects
#  Mô tả: Đọc file config/projects.yaml và config/platform-mapping.yaml,
#         sau đó gọi GitLab API để tự động tạo project và gán CI/CD variables.
#
#  Yêu cầu:
#  - Cài đặt `yq` và `jq`.
#  - Export biến môi trường: `GITLAB_API_TOKEN` với quyền admin.
# ==============================================================================

set -e # Exit script on any error

GITLAB_URL="https://your-gitlab.com" # Thay bằng URL GitLab của bạn
GROUP_ID="YOUR_GROUP_ID"             # Thay bằng ID của group sẽ chứa các project

if [ -z "$GITLAB_API_TOKEN" ]; then
  echo "Lỗi: Vui lòng export biến môi trường GITLAB_API_TOKEN."
  exit 1
fi

# Đọc danh sách project từ file YAML
PROJECT_NAMES=$(yq e '.projects[].name' ../config/projects.yaml)

for project_name in $PROJECT_NAMES; do
  echo "--- Đang xử lý project: $project_name ---"

  # 1. Gọi GitLab API để tạo project
  echo "Tạo project trên GitLab..."
  curl --request POST --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" \
       --data "name=$project_name&namespace_id=$GROUP_ID" \
       "$GITLAB_URL/api/v4/projects"

  # 2. Lấy DEPLOY_TARGET từ file mapping
  deploy_target=$(yq e ".mapping.$project_name" ../config/platform-mapping.yaml)
  echo "Gán biến DEPLOY_TARGET = $deploy_target"

  # 3. Gọi GitLab API để gán biến CI/CD (Cần có project ID, phần này cần hoàn thiện thêm)
  # PROJECT_ID=$(curl --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" "$GITLAB_URL/api/v4/projects?search=$project_name" | jq '.[0].id')
  # curl --request POST --header "PRIVATE-TOKEN: $GITLAB_API_TOKEN" \
  #      --data "key=DEPLOY_TARGET&value=$deploy_target" \
  #      "$GITLAB_URL/api/v4/projects/$PROJECT_ID/variables"

  echo "Hoàn thành cho project: $project_name"
done
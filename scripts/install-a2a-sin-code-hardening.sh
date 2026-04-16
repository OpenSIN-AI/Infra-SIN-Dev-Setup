#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DROPIN_SOURCE="$ROOT_DIR/systemd/a2a-sin-code-hardening.conf"
JOURNALD_SOURCE="$ROOT_DIR/systemd/journald.conf.d/90-oci-limits.conf"
RUNNER_CLEANUP_SERVICE_SOURCE="$ROOT_DIR/systemd/runner-cleanup.service"
RUNNER_CLEANUP_TIMER_SOURCE="$ROOT_DIR/systemd/runner-cleanup.timer"
GUARDIAN_SERVICE_SOURCE="$ROOT_DIR/systemd/oci-space-guardian.service"
GUARDIAN_TIMER_SOURCE="$ROOT_DIR/systemd/oci-space-guardian.timer"
EMERGENCY_SERVICE_SOURCE="$ROOT_DIR/systemd/oci-emergency-disk-guard.service"
EMERGENCY_TIMER_SOURCE="$ROOT_DIR/systemd/oci-emergency-disk-guard.timer"
LOGROTATE_SERVICE_SOURCE="$ROOT_DIR/systemd/oci-log-rotation.service"
LOGROTATE_TIMER_SOURCE="$ROOT_DIR/systemd/oci-log-rotation.timer"
SELF_TEST_SERVICE_SOURCE="$ROOT_DIR/systemd/oci-disk-self-test.service"
SELF_TEST_TIMER_SOURCE="$ROOT_DIR/systemd/oci-disk-self-test.timer"
RUNNER_CLEANUP_SCRIPT_SOURCE="$ROOT_DIR/scripts/cleanup-runner-libs.sh"
GUARDIAN_SCRIPT_SOURCE="$ROOT_DIR/scripts/oci-space-guardian.sh"
EMERGENCY_SCRIPT_SOURCE="$ROOT_DIR/scripts/oci-emergency-disk-guard.sh"
LOGROTATE_SCRIPT_SOURCE="$ROOT_DIR/scripts/oci-log-rotation.sh"
SELF_TEST_SCRIPT_SOURCE="$ROOT_DIR/scripts/oci-disk-self-test.sh"

for agent in backend command frontend fullstack plugin tool; do
  service_name="a2a-sin-code-${agent}.service"
  dropin_dir="/etc/systemd/system/${service_name}.d"
  sudo mkdir -p "$dropin_dir"
  sudo install -m 0644 "$DROPIN_SOURCE" "$dropin_dir/hardening.conf"
done

sudo mkdir -p /etc/systemd/journald.conf.d
sudo install -m 0644 "$JOURNALD_SOURCE" /etc/systemd/journald.conf.d/90-oci-limits.conf
sudo install -m 0755 "$RUNNER_CLEANUP_SCRIPT_SOURCE" /usr/local/bin/cleanup-runner-libs.sh
sudo install -m 0755 "$GUARDIAN_SCRIPT_SOURCE" /usr/local/bin/oci-space-guardian.sh
sudo install -m 0755 "$EMERGENCY_SCRIPT_SOURCE" /usr/local/bin/oci-emergency-disk-guard.sh
sudo install -m 0755 "$LOGROTATE_SCRIPT_SOURCE" /usr/local/bin/oci-log-rotation.sh
sudo install -m 0755 "$SELF_TEST_SCRIPT_SOURCE" /usr/local/bin/oci-disk-self-test.sh
sudo install -m 0644 "$RUNNER_CLEANUP_SERVICE_SOURCE" /etc/systemd/system/runner-cleanup.service
sudo install -m 0644 "$RUNNER_CLEANUP_TIMER_SOURCE" /etc/systemd/system/runner-cleanup.timer
sudo install -m 0644 "$GUARDIAN_SERVICE_SOURCE" /etc/systemd/system/oci-space-guardian.service
sudo install -m 0644 "$GUARDIAN_TIMER_SOURCE" /etc/systemd/system/oci-space-guardian.timer
sudo install -m 0644 "$EMERGENCY_SERVICE_SOURCE" /etc/systemd/system/oci-emergency-disk-guard.service
sudo install -m 0644 "$EMERGENCY_TIMER_SOURCE" /etc/systemd/system/oci-emergency-disk-guard.timer
sudo install -m 0644 "$LOGROTATE_SERVICE_SOURCE" /etc/systemd/system/oci-log-rotation.service
sudo install -m 0644 "$LOGROTATE_TIMER_SOURCE" /etc/systemd/system/oci-log-rotation.timer
sudo install -m 0644 "$SELF_TEST_SERVICE_SOURCE" /etc/systemd/system/oci-disk-self-test.service
sudo install -m 0644 "$SELF_TEST_TIMER_SOURCE" /etc/systemd/system/oci-disk-self-test.timer

sudo systemctl daemon-reload
sudo systemctl restart systemd-journald
sudo systemctl enable --now \
  runner-cleanup.timer \
  oci-space-guardian.timer \
  oci-emergency-disk-guard.timer \
  oci-log-rotation.timer \
  oci-disk-self-test.timer

sudo systemctl restart \
  a2a-sin-code-backend \
  a2a-sin-code-command \
  a2a-sin-code-frontend \
  a2a-sin-code-fullstack \
  a2a-sin-code-plugin \
  a2a-sin-code-tool

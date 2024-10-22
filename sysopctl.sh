#!/bin/bash

# Function to display version information
version() {
  echo "sysopctl version 1.0.0"
}

# Function to list running services
list_services() {
  echo "Listing all active services..."
  systemctl list-units --type=service
}

# Function to view system load
system_load() {
  echo "Current system load:"
  uptime
}

# Function to start a service
start_service() {
  if [ -z "$1" ]; then
    echo "Please provide a service name to start."
  else
    echo "Starting service: $1"
    sudo systemctl start "$1"
  fi
}

# Function to stop a service
stop_service() {
  if [ -z "$1" ]; then
    echo "Please provide a service name to stop."
  else
    echo "Stopping service: $1"
    sudo systemctl stop "$1"
  fi
}

# Function to check disk usage
disk_usage() {
  echo "Disk usage by partition:"
  df -h
}

# Function to monitor system processes
process_monitor() {
  echo "Monitoring system processes (press Ctrl+C to stop)..."
  top
}

# Function to analyze system logs
logs_analyze() {
  echo "Analyzing recent critical log entries..."
  sudo journalctl -p 3 -xb
}

# Function to backup system files
backup() {
  if [ -z "$1" ]; then
    echo "Please provide a directory to back up."
  else
    backup_dir="$1"
    echo "Backing up files from $backup_dir..."
    sudo rsync -av "$backup_dir" /backup/
    echo "Backup completed for $backup_dir to /backup/"
  fi
}

# Parse command-line arguments
case "$1" in
  --version)
    version
    ;;
  service)
    case "$2" in
      list)
        list_services
        ;;
      start)
        start_service "$3"
        ;;
      stop)
        stop_service "$3"
        ;;
      *)
        echo "Unknown service command. Use: list, start <service-name>, stop <service-name>"
        ;;
    esac
    ;;
  system)
    case "$2" in
      load)
        system_load
        ;;
      *)
        echo "Unknown system command. Use: load"
        ;;
    esac
    ;;
  disk)
    case "$2" in
      usage)
        disk_usage
        ;;
      *)
        echo "Unknown disk command. Use: usage"
        ;;
    esac
    ;;
  process)
    case "$2" in
      monitor)
        process_monitor
        ;;
      *)
        echo "Unknown process command. Use: monitor"
        ;;
    esac
    ;;
  logs)
    case "$2" in
      analyze)
        logs_analyze
        ;;
      *)
        echo "Unknown logs command. Use: analyze"
        ;;
    esac
    ;;
  backup)
    backup "$2"
    ;;
  *)
    echo "Usage: $0 {--version|service|system|disk|process|logs|backup}"
    ;;
esac


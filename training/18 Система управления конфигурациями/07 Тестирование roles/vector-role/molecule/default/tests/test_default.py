import os
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

def test_vector_binary_exists(host):
    """Проверяем, что исполняемый файл Vector существует и является исполняемым."""
    
    vector_symlink = host.file("/usr/bin/vector")
    assert vector_symlink.exists
    assert vector_symlink.is_symlink
    assert vector_symlink.user == 'root'

    vector_bin = host.file("/opt/vector/bin/vector")
    assert vector_bin.exists
    assert vector_bin.is_file
    assert vector_bin.mode == 0o755

def test_service_config_present(host):
    """Проверяем, что unit-файл Systemd существует."""
    

    service_file = host.file("/etc/systemd/system/vector.service")
    assert service_file.exists
    assert service_file.user == 'root'
    assert service_file.group == 'root'
    assert service_file.mode == 0o644

def test_config_file_present(host):
    """Проверяем наличие основного файла конфигурации."""

    config_file = host.file("/etc/vector/vector.toml") 
    assert config_file.exists
    assert config_file.user == 'root'
    assert config_file.group == 'root'
    assert config_file.mode == 0o644
    assert config_file.content.strip() != b"" 
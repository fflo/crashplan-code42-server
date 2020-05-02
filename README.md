## Code42 ProServer (Docker)

This docker container provides Code42 for Enterprise: Crashplan Server (proserver)

### Tags

- `7.0.4, latest`
- `7.0.3`
- `7.0.2`
- `7.0.0`
- `6.8.7`
- `6.8.4`
- `6.7.4`
- `6.7.3`
- `6.7.2`
- `6.5.2`
- `6.0.5`
- `5.4.5`
- `5.3.2`

### Example Usage

#### Version 7
```
docker run -d --name crashplan-code42-server \
  -p 4282:4282 \
  -p 4285:4285 \
  -p 4287:4287 \
  -e TIMEZONE='America/Los_Angeles' \
  -v /private/proserver-db:/crashplan/proserver/server/db \
  -v /private/proserver-data:/crashplan/proserver/data \
  -v /private/proserver-log:/crashplan/proserver/log \
  fflo/crashplan-code42-server
```

#### Version 6 or older
```
docker run -d --name crashplan-code42-server \
  -p 4282:4282 \
  -p 4285:4285 \
  -p 4287:4287 \
  -e TIMEZONE='America/Los_Angeles' \
  -v /private/proserver-db:/opt/proserver/db \
  -v /private/proserver-data:/var/opt/proserver \
  -v /private/proserver-log:/var/log/proserver \
  fflo/crashplan-code42-server
```

### Hints
Port 4280 can be added to the list above, if insecure web access (http) is needed.
Admin Console can be access using https://[publish-IP]:4285/console [2]

### What's new
Starting with version 7 code42-server (proserver) is now running as user crashplan instead of root for security reasons.

### Environment Variables

Variable | Description
--- | ---
TIMEZONE | Local Timezone [Reference](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

Default Timezone: UTC

### Mapped Volumes

#### Version 7
Path | Description
--- | ---
/crashplan/proserver/server/db | H2 database
/crashplan/proserver/log | Logs
/crashplan/proserver/data | Everything else including archives

#### Version 6 or older
Path | Description
--- | ---
/opt/proserver/db | H2 database
/var/log/proserver | Logs
/var/opt/proserver | Everything else including archives

### Ports

You will need to map the follwing ports at the very least for full functionality:

[4280, 4282, 4285, 4287][1]

[1]: https://support.code42.com/Administrator/6/Planning_and_installing/Code42_platform_hardware_and_software_requirements#Inbound_ports
[2]:
https://support.code42.com/Administrator/6/Planning_and_installing/Install_the_Code42_platform_private_cloud#Step_3:_Activate_your_Code42_server

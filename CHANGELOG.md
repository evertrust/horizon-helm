# Changelog

## [0.20.0](https://github.com/evertrust/horizon-helm/compare/v0.19.2...v0.20.0) (2025-03-05)


### Features

* **0.5.10:** Support for topologySpreadConstraints ([4574310](https://github.com/evertrust/horizon-helm/commit/4574310d19e06035624be714876c645de824b1b0))
* **0.5.11:** Bumped chart version ([c609adc](https://github.com/evertrust/horizon-helm/commit/c609adcebf0f9ff73e4517b0583a5a0f0f682b7f))
* **0.5.11:** Support for specifying client certificate CAs ([469bb10](https://github.com/evertrust/horizon-helm/commit/469bb10c77e77b8d988d1fb1049e12602a57d08d))
* **0.5.3:** Configure SCEP compatibility mode ([4cc976a](https://github.com/evertrust/horizon-helm/commit/4cc976a5dec3d403a761c15aedaaad7867013499))
* **0.7.0:** Allow overriding imageRegistry globally ([770ca8c](https://github.com/evertrust/horizon-helm/commit/770ca8cb6e7a9252fab23a6342b6e2566a2635b4))
* **0.7.0:** Cluster bootstrapping now uses the Kubernetes API instead of a headless service ([036e748](https://github.com/evertrust/horizon-helm/commit/036e7486cd5ca28ee37ad63425822261422b3048))
* **0.7.0:** Make the pod's DNS settings configurable ([f4af3c5](https://github.com/evertrust/horizon-helm/commit/f4af3c540d1f1bb24924ec72ccae1d1d456803b2))
* **0.7.0:** Migrate to the new configuration framework using environment variables ([c5961ea](https://github.com/evertrust/horizon-helm/commit/c5961ead343e23739b8cf187a0f0663244b6d700))
* **0.7.0:** Take advantage of the bootstraping feature bundled in Horizon ([63db778](https://github.com/evertrust/horizon-helm/commit/63db7789f349ee0034532ca0469f633cc3ee101b))
* **0.8.6:** Connection between pods by IP ([1ab8d2b](https://github.com/evertrust/horizon-helm/commit/1ab8d2b415cb6aba191724c13d5733bab1544f8d))
* **analytics:** support analytics ([d575ed0](https://github.com/evertrust/horizon-helm/commit/d575ed08028431c8ed839e86df4e218a4851733e))
* **backup:** add backup support ([#26](https://github.com/evertrust/horizon-helm/issues/26)) ([115b1ba](https://github.com/evertrust/horizon-helm/commit/115b1ba6f6e05c97a1079eb5c3eb621ec2c03dc9))
* **extraObjects:** support creation of extra manifests via values ([#5](https://github.com/evertrust/horizon-helm/issues/5)) ([ecfef59](https://github.com/evertrust/horizon-helm/commit/ecfef599a6888af2dd27bebf4f15367628f501bd))
* **healthcheck:** update readiness and liveness probs ([#48](https://github.com/evertrust/horizon-helm/issues/48)) ([cccf28e](https://github.com/evertrust/horizon-helm/commit/cccf28e6a9a52bcb6977c73d0af0fac716a856c9))
* **ingress:** remove app-root redirect ([#69](https://github.com/evertrust/horizon-helm/issues/69)) ([47fde1b](https://github.com/evertrust/horizon-helm/commit/47fde1be76346770b96faab6d2bdcd70e3e79196))
* **intialAdminHashPassword:** support ([#15](https://github.com/evertrust/horizon-helm/issues/15)) ([1765372](https://github.com/evertrust/horizon-helm/commit/17653725c401fa02b43c4b9718977fc658bc73bc))
* **leases:** switch to native kubernetes leases ([bca9198](https://github.com/evertrust/horizon-helm/commit/bca9198383c6546effa03e3debcbb0af27590ea6))
* **metrics:** enable horizon advanced metrics ([#62](https://github.com/evertrust/horizon-helm/issues/62)) ([d4aebf3](https://github.com/evertrust/horizon-helm/commit/d4aebf3687b12eab9ce8ef2f5d99760f60f4c9e1))
* **metrics:** support metrics configuration ([#24](https://github.com/evertrust/horizon-helm/issues/24)) ([6f269ed](https://github.com/evertrust/horizon-helm/commit/6f269ed67e230a84c19e800692e5db4934dbbbd7))
* migrate from akka lease to pekko lease ([#7](https://github.com/evertrust/horizon-helm/issues/7)) ([20665dd](https://github.com/evertrust/horizon-helm/commit/20665ddfd825f6723764ffe9058383bc0c7b8dc4))
* **rbac:** ability to disable rbac creation ([#66](https://github.com/evertrust/horizon-helm/issues/66)) ([0516f04](https://github.com/evertrust/horizon-helm/commit/0516f0492134ea18c4b5f1bfec87d34274f322ff))


### Bug Fixes

* **0.5.12:** Fixed clientCertificateCASecrets application ([8994164](https://github.com/evertrust/horizon-helm/commit/89941646a4a75d2a25a63408b6da3bed24f01555))
* **0.6.1:** Override selectors used to bootstrap a cluster ([0e26c5b](https://github.com/evertrust/horizon-helm/commit/0e26c5bc307ea100e91e9c494c1ca16a9e06e1e8))
* **0.7.0:** CI pipline optimization ([5c68b27](https://github.com/evertrust/horizon-helm/commit/5c68b27552a3680638bb5276c5c24c90797daa25))
* **0.7.0:** Don't use clientCertificateHeader if not specified in values ([6905f7b](https://github.com/evertrust/horizon-helm/commit/6905f7b6c3f845d254cda3f81f58bfce304f4c8e))
* **0.8.0:** Restored the allowedHosts feature ([ba39442](https://github.com/evertrust/horizon-helm/commit/ba394422e91dc8270b07dafeaaf7c947259e8cbb))
* **0.8.6:** Fixed loggers that weren't taken into account ([049c6c2](https://github.com/evertrust/horizon-helm/commit/049c6c26bc511090b00e66299c9decdf076a1145))
* **0.9.1:** removed reference to non-existant traefik middleware ([62f95ba](https://github.com/evertrust/horizon-helm/commit/62f95baa03d0c2d97e187c9d8198f080b00f845d))
* backup command ([c955a6c](https://github.com/evertrust/horizon-helm/commit/c955a6c95c01901d96c702e2999bcff15ba63fac))
* **backup:** add toolbox exec path ([f2e7861](https://github.com/evertrust/horizon-helm/commit/f2e7861acb4a29e879e80ba5c723f2341c76c761))
* **backup:** remove global registry override for backup image ([09fdfa2](https://github.com/evertrust/horizon-helm/commit/09fdfa287550f6735db9f78736f90ba4405e9631))
* **backup:** set restartPolicy to Never for job ([c28e71f](https://github.com/evertrust/horizon-helm/commit/c28e71f8dcfa8ea88559e343592be45a126ad4cb))
* **backup:** use args instead of command for backup ([2bb7d37](https://github.com/evertrust/horizon-helm/commit/2bb7d37d77a8afdf8556b8f15ead035ed076bedc))
* bump horizon 2.6.3 ([#11](https://github.com/evertrust/horizon-helm/issues/11)) ([4aceef1](https://github.com/evertrust/horizon-helm/commit/4aceef13ceacabbd00b73a381a614f269b7d9b68))
* bump horizon 2.6.4 ([#13](https://github.com/evertrust/horizon-helm/issues/13)) ([7e7be0f](https://github.com/evertrust/horizon-helm/commit/7e7be0fef8d41f0591583a91273b81619e967d0a))
* bump horizon 2.6.5 ([#17](https://github.com/evertrust/horizon-helm/issues/17)) ([2935eb4](https://github.com/evertrust/horizon-helm/commit/2935eb49b945b0568ffa0a9874ddb2abbfc46e32))
* bump horizon 2.6.6 ([#18](https://github.com/evertrust/horizon-helm/issues/18)) ([7999219](https://github.com/evertrust/horizon-helm/commit/79992190c18d346dd71a6cce823fbd604ad1558a))
* bump horizon 2.6.7 ([#20](https://github.com/evertrust/horizon-helm/issues/20)) ([9adacf1](https://github.com/evertrust/horizon-helm/commit/9adacf11eff13c659fac81cf03474591d4c38bad))
* bump horizon 2.6.8 ([#22](https://github.com/evertrust/horizon-helm/issues/22)) ([3160cf3](https://github.com/evertrust/horizon-helm/commit/3160cf35f421a7f4f8a881ae13f9bd16dff84c58))
* bump horizon 2.6.9 ([#41](https://github.com/evertrust/horizon-helm/issues/41)) ([0e4d7cd](https://github.com/evertrust/horizon-helm/commit/0e4d7cd6848ed43005ea38abcbe3bb775fdaf4c7))
* bump horizon 2.7.0 ([#52](https://github.com/evertrust/horizon-helm/issues/52)) ([04df269](https://github.com/evertrust/horizon-helm/commit/04df2697986cc2b9b71adfd420e3f12b656dd7c6))
* bump horizon 2.7.1 ([#64](https://github.com/evertrust/horizon-helm/issues/64)) ([c6817d2](https://github.com/evertrust/horizon-helm/commit/c6817d2e304ec2b10f8483de0f3949a6c9048ce2))
* bump horizon 2.7.2 ([#71](https://github.com/evertrust/horizon-helm/issues/71)) ([02711c6](https://github.com/evertrust/horizon-helm/commit/02711c6174c8ac08b6079f1b595d875af9d08512))
* bump horizon 2.7.3 ([#73](https://github.com/evertrust/horizon-helm/issues/73)) ([8337531](https://github.com/evertrust/horizon-helm/commit/83375319aa2b597bd97ea63b907c1c83d8060aec))
* bump horizon to 2.6.1 ([#8](https://github.com/evertrust/horizon-helm/issues/8)) ([05fa5ae](https://github.com/evertrust/horizon-helm/commit/05fa5aee4b9f25497a9780a51edeb6eccf72c4fe))
* bump toolbox version ([f6992a3](https://github.com/evertrust/horizon-helm/commit/f6992a34f334001f2c2d963b016bc70fca2f52ac))
* **ci:** use release-please ([bae07f3](https://github.com/evertrust/horizon-helm/commit/bae07f3e91b3b70fd10fb534831a8317aa76ee3b))
* cronJob name lenght ([#35](https://github.com/evertrust/horizon-helm/issues/35)) ([a659ada](https://github.com/evertrust/horizon-helm/commit/a659ada609811252fd98505ebea22b2e30200407))
* horizon bump to 2.6.2 ([#9](https://github.com/evertrust/horizon-helm/issues/9)) ([798131e](https://github.com/evertrust/horizon-helm/commit/798131eaecc209213b3e772bba823bf1845ec35e))
* **rbac:** move end template condition to the end of file ([#67](https://github.com/evertrust/horizon-helm/issues/67)) ([ee96d75](https://github.com/evertrust/horizon-helm/commit/ee96d75d50d3ea20f1819ad066c212758893ec1c))
* removed default event expiration ttl ([ecaa689](https://github.com/evertrust/horizon-helm/commit/ecaa689dfdd30a4f82d327bf02ef53d5f54d3bd2))
* security context rollback ([#37](https://github.com/evertrust/horizon-helm/issues/37)) ([c247ac8](https://github.com/evertrust/horizon-helm/commit/c247ac8e2fadd8dea35b878188f8cf2af09a6211))
* set resource limit/request and security context for upgrade/back… ([#33](https://github.com/evertrust/horizon-helm/issues/33)) ([cfe4082](https://github.com/evertrust/horizon-helm/commit/cfe4082b447c10621e3073ee5c1258c2af81a224))
* toolbox bump to 0.3.0 ([#39](https://github.com/evertrust/horizon-helm/issues/39)) ([228feaf](https://github.com/evertrust/horizon-helm/commit/228feaf7218f2874b300e55379d0ce0fc74a1362))
* **upgrade:** script hotfix to r1 ([#49](https://github.com/evertrust/horizon-helm/issues/49)) ([5fe06b8](https://github.com/evertrust/horizon-helm/commit/5fe06b877351d20f303143687f1c5343ea7e38ba))

## [0.19.2](https://github.com/evertrust/horizon-helm/compare/v0.19.1...v0.19.2) (2025-03-05)


### Bug Fixes

* bump horizon 2.7.3 ([#73](https://github.com/evertrust/horizon-helm/issues/73)) ([8337531](https://github.com/evertrust/horizon-helm/commit/83375319aa2b597bd97ea63b907c1c83d8060aec))

## [0.19.1](https://github.com/evertrust/horizon-helm/compare/v0.19.0...v0.19.1) (2025-02-26)


### Bug Fixes

* bump horizon 2.7.2 ([#71](https://github.com/evertrust/horizon-helm/issues/71)) ([02711c6](https://github.com/evertrust/horizon-helm/commit/02711c6174c8ac08b6079f1b595d875af9d08512))

## [0.19.0](https://github.com/evertrust/horizon-helm/compare/v0.18.1...v0.19.0) (2025-02-03)


### Features

* **ingress:** remove app-root redirect ([#69](https://github.com/evertrust/horizon-helm/issues/69)) ([47fde1b](https://github.com/evertrust/horizon-helm/commit/47fde1be76346770b96faab6d2bdcd70e3e79196))

## [0.18.1](https://github.com/evertrust/horizon-helm/compare/v0.18.0...v0.18.1) (2025-01-24)


### Bug Fixes

* **rbac:** move end template condition to the end of file ([#67](https://github.com/evertrust/horizon-helm/issues/67)) ([ee96d75](https://github.com/evertrust/horizon-helm/commit/ee96d75d50d3ea20f1819ad066c212758893ec1c))

## [0.18.0](https://github.com/evertrust/horizon-helm/compare/v0.17.0...v0.18.0) (2025-01-24)


### Features

* **rbac:** ability to disable rbac creation ([#66](https://github.com/evertrust/horizon-helm/issues/66)) ([0516f04](https://github.com/evertrust/horizon-helm/commit/0516f0492134ea18c4b5f1bfec87d34274f322ff))


### Bug Fixes

* bump horizon 2.7.1 ([#64](https://github.com/evertrust/horizon-helm/issues/64)) ([c6817d2](https://github.com/evertrust/horizon-helm/commit/c6817d2e304ec2b10f8483de0f3949a6c9048ce2))

## [0.17.0](https://github.com/evertrust/horizon-helm/compare/v0.16.0...v0.17.0) (2025-01-15)


### Features

* **metrics:** enable horizon advanced metrics ([#62](https://github.com/evertrust/horizon-helm/issues/62)) ([d4aebf3](https://github.com/evertrust/horizon-helm/commit/d4aebf3687b12eab9ce8ef2f5d99760f60f4c9e1))

## [0.16.0](https://github.com/evertrust/horizon-helm/compare/v0.15.0...v0.16.0) (2025-01-15)


### Features

* **analytics:** support analytics ([d575ed0](https://github.com/evertrust/horizon-helm/commit/d575ed08028431c8ed839e86df4e218a4851733e))
* **leases:** switch to native kubernetes leases ([bca9198](https://github.com/evertrust/horizon-helm/commit/bca9198383c6546effa03e3debcbb0af27590ea6))

## [0.15.0](https://github.com/evertrust/horizon-helm/compare/v0.14.11...v0.15.0) (2025-01-10)


### Features

* **healthcheck:** update readiness and liveness probs ([#48](https://github.com/evertrust/horizon-helm/issues/48)) ([cccf28e](https://github.com/evertrust/horizon-helm/commit/cccf28e6a9a52bcb6977c73d0af0fac716a856c9))


### Bug Fixes

* bump horizon 2.7.0 ([#52](https://github.com/evertrust/horizon-helm/issues/52)) ([04df269](https://github.com/evertrust/horizon-helm/commit/04df2697986cc2b9b71adfd420e3f12b656dd7c6))

## [0.14.11](https://github.com/evertrust/horizon-helm/compare/v0.14.10...v0.14.11) (2025-01-07)


### Bug Fixes

* **upgrade:** script hotfix to r1 ([#49](https://github.com/evertrust/horizon-helm/issues/49)) ([5fe06b8](https://github.com/evertrust/horizon-helm/commit/5fe06b877351d20f303143687f1c5343ea7e38ba))

## [0.14.10](https://github.com/evertrust/horizon-helm/compare/v0.14.9...v0.14.10) (2024-12-19)


### Bug Fixes

* bump horizon 2.6.9 ([#41](https://github.com/evertrust/horizon-helm/issues/41)) ([0e4d7cd](https://github.com/evertrust/horizon-helm/commit/0e4d7cd6848ed43005ea38abcbe3bb775fdaf4c7))

## [0.14.9](https://github.com/evertrust/horizon-helm/compare/v0.14.8...v0.14.9) (2024-12-13)


### Bug Fixes

* toolbox bump to 0.3.0 ([#39](https://github.com/evertrust/horizon-helm/issues/39)) ([228feaf](https://github.com/evertrust/horizon-helm/commit/228feaf7218f2874b300e55379d0ce0fc74a1362))

## [0.14.8](https://github.com/evertrust/horizon-helm/compare/v0.14.7...v0.14.8) (2024-12-10)


### Bug Fixes

* security context rollback ([#37](https://github.com/evertrust/horizon-helm/issues/37)) ([c247ac8](https://github.com/evertrust/horizon-helm/commit/c247ac8e2fadd8dea35b878188f8cf2af09a6211))

## [0.14.7](https://github.com/evertrust/horizon-helm/compare/v0.14.6...v0.14.7) (2024-12-09)


### Bug Fixes

* cronJob name lenght ([#35](https://github.com/evertrust/horizon-helm/issues/35)) ([a659ada](https://github.com/evertrust/horizon-helm/commit/a659ada609811252fd98505ebea22b2e30200407))

## [0.14.6](https://github.com/evertrust/horizon-helm/compare/v0.14.5...v0.14.6) (2024-12-09)


### Bug Fixes

* set resource limit/request and security context for upgrade/back… ([#33](https://github.com/evertrust/horizon-helm/issues/33)) ([cfe4082](https://github.com/evertrust/horizon-helm/commit/cfe4082b447c10621e3073ee5c1258c2af81a224))

## [0.14.5](https://github.com/evertrust/horizon-helm/compare/v0.14.4...v0.14.5) (2024-12-06)


### Bug Fixes

* backup command ([c955a6c](https://github.com/evertrust/horizon-helm/commit/c955a6c95c01901d96c702e2999bcff15ba63fac))

## [0.14.4](https://github.com/evertrust/horizon-helm/compare/v0.14.3...v0.14.4) (2024-12-06)


### Bug Fixes

* **backup:** use args instead of command for backup ([2bb7d37](https://github.com/evertrust/horizon-helm/commit/2bb7d37d77a8afdf8556b8f15ead035ed076bedc))

## [0.14.3](https://github.com/evertrust/horizon-helm/compare/v0.14.2...v0.14.3) (2024-12-06)


### Bug Fixes

* **backup:** add toolbox exec path ([f2e7861](https://github.com/evertrust/horizon-helm/commit/f2e7861acb4a29e879e80ba5c723f2341c76c761))

## [0.14.2](https://github.com/evertrust/horizon-helm/compare/v0.14.1...v0.14.2) (2024-12-06)


### Bug Fixes

* **backup:** remove global registry override for backup image ([09fdfa2](https://github.com/evertrust/horizon-helm/commit/09fdfa287550f6735db9f78736f90ba4405e9631))

## [0.14.1](https://github.com/evertrust/horizon-helm/compare/v0.14.0...v0.14.1) (2024-12-06)


### Bug Fixes

* **backup:** set restartPolicy to Never for job ([c28e71f](https://github.com/evertrust/horizon-helm/commit/c28e71f8dcfa8ea88559e343592be45a126ad4cb))

## [0.14.0](https://github.com/evertrust/horizon-helm/compare/v0.13.0...v0.14.0) (2024-12-06)


### Features

* **backup:** add backup support ([#26](https://github.com/evertrust/horizon-helm/issues/26)) ([115b1ba](https://github.com/evertrust/horizon-helm/commit/115b1ba6f6e05c97a1079eb5c3eb621ec2c03dc9))


### Bug Fixes

* bump toolbox version ([f6992a3](https://github.com/evertrust/horizon-helm/commit/f6992a34f334001f2c2d963b016bc70fca2f52ac))

## [0.13.0](https://github.com/evertrust/horizon-helm/compare/v0.12.3...v0.13.0) (2024-11-21)


### Features

* **metrics:** support metrics configuration ([#24](https://github.com/evertrust/horizon-helm/issues/24)) ([6f269ed](https://github.com/evertrust/horizon-helm/commit/6f269ed67e230a84c19e800692e5db4934dbbbd7))

## [0.12.3](https://github.com/evertrust/horizon-helm/compare/v0.12.2...v0.12.3) (2024-11-20)


### Bug Fixes

* bump horizon 2.6.8 ([#22](https://github.com/evertrust/horizon-helm/issues/22)) ([3160cf3](https://github.com/evertrust/horizon-helm/commit/3160cf35f421a7f4f8a881ae13f9bd16dff84c58))

## [0.12.2](https://github.com/evertrust/horizon-helm/compare/v0.12.1...v0.12.2) (2024-11-12)


### Bug Fixes

* bump horizon 2.6.7 ([#20](https://github.com/evertrust/horizon-helm/issues/20)) ([9adacf1](https://github.com/evertrust/horizon-helm/commit/9adacf11eff13c659fac81cf03474591d4c38bad))

## [0.12.1](https://github.com/evertrust/horizon-helm/compare/v0.12.0...v0.12.1) (2024-10-28)


### Bug Fixes

* bump horizon 2.6.6 ([#18](https://github.com/evertrust/horizon-helm/issues/18)) ([7999219](https://github.com/evertrust/horizon-helm/commit/79992190c18d346dd71a6cce823fbd604ad1558a))

## [0.12.0](https://github.com/evertrust/horizon-helm/compare/v0.11.5...v0.12.0) (2024-10-25)


### Features

* **intialAdminHashPassword:** support ([#15](https://github.com/evertrust/horizon-helm/issues/15)) ([1765372](https://github.com/evertrust/horizon-helm/commit/17653725c401fa02b43c4b9718977fc658bc73bc))


### Bug Fixes

* bump horizon 2.6.5 ([#17](https://github.com/evertrust/horizon-helm/issues/17)) ([2935eb4](https://github.com/evertrust/horizon-helm/commit/2935eb49b945b0568ffa0a9874ddb2abbfc46e32))

## [0.11.5](https://github.com/evertrust/horizon-helm/compare/v0.11.4...v0.11.5) (2024-10-15)


### Bug Fixes

* bump horizon 2.6.4 ([#13](https://github.com/evertrust/horizon-helm/issues/13)) ([7e7be0f](https://github.com/evertrust/horizon-helm/commit/7e7be0fef8d41f0591583a91273b81619e967d0a))

## [0.11.4](https://github.com/evertrust/horizon-helm/compare/v0.11.3...v0.11.4) (2024-10-07)


### Bug Fixes

* bump horizon 2.6.3 ([#11](https://github.com/evertrust/horizon-helm/issues/11)) ([4aceef1](https://github.com/evertrust/horizon-helm/commit/4aceef13ceacabbd00b73a381a614f269b7d9b68))

## [0.11.3](https://github.com/evertrust/horizon-helm/compare/0.11.2...v0.11.3) (2024-10-03)


### Bug Fixes

* **ci:** use release-please ([bae07f3](https://github.com/evertrust/horizon-helm/commit/bae07f3e91b3b70fd10fb534831a8317aa76ee3b))
* removed default event expiration ttl ([ecaa689](https://github.com/evertrust/horizon-helm/commit/ecaa689dfdd30a4f82d327bf02ef53d5f54d3bd2))

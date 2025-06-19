# Changelog

## [0.22.4](https://github.com/evertrust/horizon-helm/compare/v0.22.3...v0.22.4) (2025-06-19)


### Bug Fixes

* **hpa:** support StatefulSet target ref ([#108](https://github.com/evertrust/horizon-helm/issues/108)) ([b9956bc](https://github.com/evertrust/horizon-helm/commit/b9956bc6fb4f3475ebdd67e1557f23d5ee2f3686))

## [0.22.3](https://github.com/evertrust/horizon-helm/compare/v0.22.2...v0.22.3) (2025-06-13)


### Bug Fixes

* add internal config injector ([#106](https://github.com/evertrust/horizon-helm/issues/106)) ([e71b2d5](https://github.com/evertrust/horizon-helm/commit/e71b2d577f337ca67e27444dd8b2d349268c6aa8))
* statefulset strategy ([#105](https://github.com/evertrust/horizon-helm/issues/105)) ([1fe76d3](https://github.com/evertrust/horizon-helm/commit/1fe76d31771034793f17441f6cbbc4162f78fd98))

## [0.22.2](https://github.com/evertrust/horizon-helm/compare/v0.22.1...v0.22.2) (2025-06-06)


### Bug Fixes

* bump horizon 2.7.6 ([#103](https://github.com/evertrust/horizon-helm/issues/103)) ([382090b](https://github.com/evertrust/horizon-helm/commit/382090b3e85aa7cb8e9c098dc2e7bb8582faa6ae))

## [0.22.1](https://github.com/evertrust/horizon-helm/compare/v0.22.0...v0.22.1) (2025-06-03)


### Bug Fixes

* application.conf newline template ([#100](https://github.com/evertrust/horizon-helm/issues/100)) ([8ca8131](https://github.com/evertrust/horizon-helm/commit/8ca813152b1a163eee1d5e92b91e4db754dc5a53))
* create rbac when an external service account is used ([#101](https://github.com/evertrust/horizon-helm/issues/101)) ([51fa4ee](https://github.com/evertrust/horizon-helm/commit/51fa4ee2220940cd57fb0b18472c9f5fce58da10))

## [0.22.0](https://github.com/evertrust/horizon-helm/compare/v0.21.0...v0.22.0) (2025-05-13)


### Features

* add json event logger by default ([#98](https://github.com/evertrust/horizon-helm/issues/98)) ([a4bf147](https://github.com/evertrust/horizon-helm/commit/a4bf147fb15a96de1b0000c844e8ec4573d00212))

## [0.21.0](https://github.com/evertrust/horizon-helm/compare/v0.20.1...v0.21.0) (2025-05-12)


### Features

* add service account support ([#95](https://github.com/evertrust/horizon-helm/issues/95)) ([aab6629](https://github.com/evertrust/horizon-helm/commit/aab6629cdeaee18847ca1b0500337455554ecb02))


### Bug Fixes

* update repository URLs to use OCI format ([#97](https://github.com/evertrust/horizon-helm/issues/97)) ([ddd1f9d](https://github.com/evertrust/horizon-helm/commit/ddd1f9da6989f2d38fbe280d2b25d0aa4c2324aa))

## [0.20.1](https://github.com/evertrust/horizon-helm/compare/v0.20.0...v0.20.1) (2025-05-07)


### Bug Fixes

* bump horizon 2.7.5 ([#94](https://github.com/evertrust/horizon-helm/issues/94)) ([1b84794](https://github.com/evertrust/horizon-helm/commit/1b84794dc9e791726fc90f46c2ee413f628fc38c))
* disable metrics for span processing ([#92](https://github.com/evertrust/horizon-helm/issues/92)) ([4fc49b3](https://github.com/evertrust/horizon-helm/commit/4fc49b3d82a33ac7da6e5bc93784b5ae8d7ddee5))

## [0.20.0](https://github.com/evertrust/horizon-helm/compare/v0.19.5...v0.20.0) (2025-03-27)


### Features

* **analytics:** enhance analytics persistency with statefuleset ([#84](https://github.com/evertrust/horizon-helm/issues/84)) ([efd2087](https://github.com/evertrust/horizon-helm/commit/efd208784291cb0fc7eead94d591aa7ee6d19d6b))


### Bug Fixes

* **backup:** propagate labels and annotation to jolsb and job's pod ([#86](https://github.com/evertrust/horizon-helm/issues/86)) ([2308ad5](https://github.com/evertrust/horizon-helm/commit/2308ad50d9d2e9a51f9b5e1c1d9315f030ab7d88))
* **typo:** persistence ([#88](https://github.com/evertrust/horizon-helm/issues/88)) ([572ab80](https://github.com/evertrust/horizon-helm/commit/572ab80d5fb8c81a55c5ce70443fa77f6de00b22))

## [0.19.5](https://github.com/evertrust/horizon-helm/compare/v0.19.4...v0.19.5) (2025-03-26)


### Bug Fixes

* bump horizon 2.7.4 ([#82](https://github.com/evertrust/horizon-helm/issues/82)) ([1f49d07](https://github.com/evertrust/horizon-helm/commit/1f49d076714f726cb0e31bcd303c4a4d67179d02))

## [0.19.4](https://github.com/evertrust/horizon-helm/compare/v0.19.3...v0.19.4) (2025-03-07)


### Bug Fixes

* fix rendering when smtp types are not strings ([#80](https://github.com/evertrust/horizon-helm/issues/80)) ([5955d05](https://github.com/evertrust/horizon-helm/commit/5955d05a7f5490ce7ea3e64a9a14db9dd0aa712c))

## [0.19.3](https://github.com/evertrust/horizon-helm/compare/v0.19.2...v0.19.3) (2025-03-07)


### Bug Fixes

* skip injecting smtp env when empty ([#78](https://github.com/evertrust/horizon-helm/issues/78)) ([e177408](https://github.com/evertrust/horizon-helm/commit/e1774082bccdb4c27d0239bf0727f19fd8fb4ef8))

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

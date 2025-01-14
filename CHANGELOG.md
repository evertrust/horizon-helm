# Changelog

## [0.16.0](https://github.com/evertrust/horizon-helm/compare/v0.15.0...v0.16.0) (2025-01-14)


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

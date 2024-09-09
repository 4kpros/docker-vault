.PHONY: docker-vault
docker-vault:
	@docker-compose up --build --no-deps -d vault

.PHONY: docker-ghcr-login
docker-ghcr-login:
	@echo ""; \
	echo "Login - GitHub Docker Registry"; \
	read -p "Enter your Github username: " gUsername; \
	read -p "Enter your Github personal access token: " gPass; \
	echo ""; \
	echo $$gPass | docker login ghcr.io -u $$gUsername --password-stdin; \

.PHONY: docker-ghcr-push
docker-ghcr-push:
	@echo ""; \
	echo "Tag - GitHub Docker Registry"; \
	gCorp="emenec-finance"; \
	gRepo="vault"; \
	localImgName="vault-vault"; \
	remoteImgName="vault"; \
	read -p "Enter your tag(default is 0.0.1): " gTag; gTag=$${gTag:-"0.0.1"}; \
	docker tag $$localImgName ghcr.io/$$gCorp/$$gRepo/$$remoteImgName:$$gTag; \
	echo ""; \
	echo "Pushing vault - GitHub Docker Registry"; \
	docker push ghcr.io/$$gCorp/$$gRepo/$$remoteImgName:$$gTag

.PHONY: docker-ghcr-pull
docker-ghcr-pull:
	@echo ""; \
	echo "Tag - GitHub Docker Registry"; \
	gCorp="emenec-finance"; \
	gRepo="vault"; \
	imgName="vault"; \
	read -p "Enter your tag(default is 0.0.1): " gTag; gTag=$${gTag:-"0.0.1"}; \
	echo ""; \
	echo "Pulling vault - GitHub Docker Registry"; \
	docker pull ghcr.io/$$gCorp/$$gRepo/$$imgName:$$gTag

<?php
interface PaymentProviderInterface {public function createOrder(int $amount,string $currency,string $receipt): array;public function verifySignature(string $body,string $signature): bool;}

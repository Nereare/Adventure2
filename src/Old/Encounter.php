<?php
namespace Nereare\Adventure;

class Encounter {

  private array      $enemies;
  private int|null   $escape;
  private int|null   $hide;

  public function __construct(
    array $enemies,
    int|null $escape = null,
    int|null $hide = null
  ) {
    //
  }
}

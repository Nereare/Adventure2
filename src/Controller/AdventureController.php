<?php
namespace App\Controller;

use App\Entity\Post;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Bundle\SecurityBundle\Security;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdventureController extends AbstractController {

  #[Route("/", name: "homepage")]
  public function index(
    EntityManagerInterface $entityManager
  ): Response {
    $postRepo = $entityManager->getRepository(Post::class);
    $posts = $postRepo->findBy(
      ["public" => true],
      ["created" => "DESC"]
    );
    return $this->render("adventure/index.html.twig", [
      "posts" => $posts,
    ]);
  }

  #[Route("/posts", name: "posts")]
  public function posts(
    EntityManagerInterface $entityManager,
    Security $security
  ): Response {
    $user = $security->getUser();
    $postRepo = $entityManager->getRepository(Post::class);
    $posts = $postRepo->findBy(
      ["author" => $user->getId()],
      ["created" => "DESC"]
    );
    return $this->render("adventure/posts.html.twig", [
      "posts" => $posts,
    ]);
  }

  #[Route("/post/{id}", name: "post_read")]
  public function post(
    Post $post
  ): Response {
    return $this->render("adventure/post.html.twig", [
      "post" => $post,
    ]);
  }
}
